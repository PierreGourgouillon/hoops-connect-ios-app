//
//  BluetoothManager.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation
import CoreBluetooth
import UIKit

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    let characteristicUUID = CBUUID(string: "ec0e")
    var characteristic: CBCharacteristic?

    func initialize() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Powered ON")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        default:
            print("Bluetooth is not available")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        if let name = peripheral.name, name == "hoopsconnect" {
            centralManager.stopScan()
            centralManager.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "ec00")])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard peripheral.name == "hoopsconnect" else {
            centralManager?.cancelPeripheralConnection(peripheral)
            return
        }
        for service in peripheral.services! {
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            if characteristic.uuid == characteristicUUID {
                peripheral.setNotifyValue(true, for: characteristic)
                self.characteristic = characteristic
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error receiving notification for characteristic \(characteristic): \(error)")
            return
        }

        // RECEVOIR LA DONNÉE
        if let data = characteristic.value,
               let jsonString = String(data: data, encoding: .utf8),
               let jsonData = jsonString.data(using: .utf8) {
                let jsonDecoder = JSONDecoder()
                if let receivedData = try? jsonDecoder.decode(MyData.self, from: jsonData) {
                    print("Received data: \(receivedData)")
                }
            }
    }

    func writeValue(data: String) {
        if let peripheral = self.peripheral, let characteristic = self.characteristic {
            let data = data.data(using: .utf8)!
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        }
    }
}
