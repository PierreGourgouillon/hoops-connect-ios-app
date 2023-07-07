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
    @Published var latestData: BodyBluetoothModel?
    var receivedDataFragments: [String] = []

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
        guard let data = characteristic.value else { return }
        guard let fragment = String(data: data, encoding: .utf8) else { return }

        // Add the fragment to the array
        receivedDataFragments.append(fragment)

        // Add an entry to consoleHistoric
        consoleHistoric.append("Received fragment: \(fragment)")

        // Try to decode the assembled data
        if let jsonData = receivedDataFragments.joined().data(using: .utf8),
           let decodedData = try? JSONDecoder().decode(BodyBluetoothModel.self, from: jsonData) {
            // Clear the fragments array
            receivedDataFragments.removeAll()

            // Store the latest data
            latestData = decodedData

            // Add an entry to consoleHistoric
            let bodyData = Data(decodedData.data.utf8)

            if decodedData.type == "GAME_FINISHED",
               let dataUnparse: GameModel = bluetoothCoder.unParseData(data: bodyData) {
                print("DATA: \(dataUnparse.date)")
            }
        }
    }

    func writeValue<T: Encodable>(data: T, type: String) {
        guard let jsonDataString = bluetoothCoder.parseData(data: data) else {
            return
        }
        do {
            let body = BodyBluetoothModel(type: type, data: jsonDataString)
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(body)
            guard let jsonString = String(data: jsonData, encoding: .utf8),
                  let characteristic = characteristic,
                  let dataToWrite = jsonString.data(using: .utf8) else { return }

            peripheral.writeValue(dataToWrite, for: characteristic, type: .withResponse)
            consoleHistoric.append("Wrote value: \(jsonString)")
        } catch {
            print(error.localizedDescription)
        }
    }
}

