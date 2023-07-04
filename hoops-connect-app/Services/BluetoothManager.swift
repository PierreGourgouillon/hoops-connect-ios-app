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
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    let characteristicUUID = CBUUID(string: "ec0e")
    var characteristic: CBCharacteristic?
    let bluetoothCoder: BluetoothCoder = .init()
    @Published var state: BluetoothState = .initialize

    @Published var consoleHistoric: [String] = []

    func initialize() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        state = .disconnect
        centralManager.cancelPeripheralConnection(peripheral)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            state = .scanning
            consoleHistoric.append("Bluetooth: ACTIVATE")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
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
        self.peripheral = peripheral
        if let name = peripheral.name, name == "hoopsconnect" {
            centralManager.stopScan()
            consoleHistoric.append("Bluetooth: Connect to \(name)")
            centralManager.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "ec00")])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard peripheral.name == "hoopsconnect", let services = peripheral.services else {
            centralManager?.cancelPeripheralConnection(peripheral)
            return
        }
        for service in services {
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
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
                writeValue(data: DeviceBluetoothModel(), type: "CONNECTED")
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error receiving notification for characteristic \(characteristic): \(error)")
            return
        }

        guard let data = characteristic.value,
              let body: BodyBluetoothModel = bluetoothCoder.unParseData(data: data) else {
            return
        }

        let bodyData = Data(body.data.utf8)

        if body.type == "GAME",
           let dataUnparse: GameModel = bluetoothCoder.unParseData(data: bodyData) {
            consoleHistoric.append("Bluetooth: GET data \(dataUnparse)")
            print("DATA: \(dataUnparse)")
        }
    }

    func writeValue<T: Encodable>(data: T, type: String) {
        guard state == .connected, let jsonDataString = bluetoothCoder.parseData(data: data) else {
            return
        }
        let bluetoothModel = BodyBluetoothModel(type: type, data: jsonDataString)
        guard let jsonBody = bluetoothCoder.parseData(data: bluetoothModel) else {
            return
        }

        if let peripheral = self.peripheral,
           let characteristic = self.characteristic,
           let data = jsonBody.data(using: .utf8) {
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
            consoleHistoric.append("Bluetooth: POST data \(jsonBody)")
        }
    }
}
