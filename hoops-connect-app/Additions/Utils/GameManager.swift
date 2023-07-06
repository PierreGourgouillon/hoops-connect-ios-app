//
//  GameManager.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 06/07/2023.
//

import Foundation

class GameManager {
    private let bluetoothManager: BluetoothManager

    init(bluetoothManager: BluetoothManager) {
        self.bluetoothManager = bluetoothManager
    }

    func tryStartGame() {
        bluetoothManager.writeValue(data: <#T##Encodable#>, type: <#T##String#>)
    }
}
