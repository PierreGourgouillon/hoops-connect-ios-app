//
//  BluetoothManager.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation
import CoreBluetooth
import UIKit
import SwiftUI

enum BluetoothState {
    case initialize
    case scanning
    case centralPowerOff
    case connected
    case disconnect
}

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    private let characteristicUUID = CBUUID(string: "ec0e")
    private var characteristic: CBCharacteristic?
    private let bluetoothCoder: BluetoothCoder = .init()
    @Published var state: BluetoothState = .initialize
    @Published var latestData: GameModel?
    var receivedDataFragments: [String] = []
    @Published var error: BluetoothError?

    func initialize() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        guard let centralManager = centralManager else {
            self.error = .BluetoothInitializeError
            return
        }

        state = .disconnect
        centralManager.cancelPeripheralConnection(peripheral)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard let centralManager = centralManager else {
            self.error = .BluetoothInitializeError
            return
        }

        switch central.state {
        case .poweredOn:
            state = .scanning
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        case .poweredOff:
            state = .centralPowerOff
            self.error = .BluetoothDisconnect
        case .unauthorized:
            self.error = .BluetoothSendMessageError
        default:
            state = .centralPowerOff
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        guard let centralManager = centralManager else {
            self.error = .BluetoothInitializeError
            return
        }

        if let name = peripheral.name, name  == "hoopsconnect" {
            self.peripheral = peripheral
            centralManager.stopScan()
            centralManager.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "ec00")])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            centralManager?.cancelPeripheralConnection(peripheral)
            return
        }
        if peripheral.name == "hoopsconnect" {
            for service in services {
                peripheral.discoverCharacteristics([characteristicUUID], for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }
        for characteristic in characteristics {
            if characteristic.uuid == characteristicUUID {
                peripheral.setNotifyValue(true, for: characteristic)
                self.characteristic = characteristic
                state = .connected
                writeValue(data: DeviceBluetoothModel(), type: .connected)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error receiving notification for characteristic \(characteristic): \(error)")
            return
        }

        guard let data = characteristic.value,
              let fragment = String(data: data, encoding: .utf8) else {
            self.error = .BluetoothReceiveMessageError
            return
        }

        receivedDataFragments.append(fragment)

        guard let jsonData = receivedDataFragments.joined().data(using: .utf8),
              let decodedData = try? JSONDecoder().decode(BodyBluetoothModel.self, from: jsonData) else {
            return
        }
        print("UNE FOIS")
        receivedDataFragments.removeAll()

        let bodyData = Data(decodedData.data.utf8)

        if decodedData.type == "GAME_FINISHED",
           let dataUnparse: GameModel = bluetoothCoder.unParseData(data: bodyData) {
            latestData = dataUnparse
        }
    }

    // TODO: ne pas pouvoir lancer si on n'est pas en état connected
    func writeValue<T: Encodable>(data: T, type: DataModelType) {
        guard state == .connected,
              let jsonDataString = bluetoothCoder.parseData(data: data),
              let peripheral = self.peripheral else {
            self.error = .BluetoothSendMessageError
            return
        }

        let bluetoothModel = BodyBluetoothModel(type: type.rawValue, data: jsonDataString)

        guard let jsonBody = bluetoothCoder.parseData(data: bluetoothModel),
              let characteristic = self.characteristic,
              let data = jsonBody.data(using: .utf8) else {
            self.error = .BluetoothParseDataError
            return
        }
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
}

enum BluetoothError: Error {
    case BluetoothInitializeError
    case BluetoothSendMessageError
    case BluetoothReceiveMessageError
    case BluetoothParseDataError
    case BluetoothDisconnect
}
