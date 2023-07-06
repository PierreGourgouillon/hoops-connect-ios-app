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

    func tryStartGame(duration: Int, difficulty: DifficultyStatus) throws {
        let playerId = try FirebaseManager.shared.getUserId()
        let startGameModel = StartGameModel(mode: .chrono, playerId: playerId, duration: duration, difficulty: difficulty)
        bluetoothManager.writeValue(data: startGameModel, type: .gameStart)
    }
}

enum DataModelType: String {
    case connected = "CONNECTED"
    case gameStart = "GAME_START"
    case gameFinish = "GAME_FINISHED"
}
