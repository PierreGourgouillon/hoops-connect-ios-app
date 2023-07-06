//
//  GameManager.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 06/07/2023.
//

import Foundation
import Combine

enum GameError: Error {
    case bluetoothDisconnected
    case gameInitializeError
    case gameStartError
    case gameFinishError
    case unknownError
}

class GameManager: ObservableObject {
    private let bluetoothManager: BluetoothManager
    private var cancellables = Set<AnyCancellable>()
    @Published var gameError: GameError?

    init(bluetoothManager: BluetoothManager) {
        self.bluetoothManager = bluetoothManager

        bluetoothManager.$error
            .sink { [weak self] in
                switch $0 {
                case .BluetoothInitializeError:
                    self?.gameError = .gameInitializeError
                case .BluetoothParseDataError:
                    self?.gameError = .gameStartError
                case .BluetoothReceiveMessageError:
                    self?.gameError = .gameFinishError
                case .BluetoothSendMessageError:
                    self?.gameError = .gameStartError
                case .BluetoothDisconnect:
                    self?.gameError = .bluetoothDisconnected
                case .none:
                    self?.gameError = nil
                }
            }
            .store(in: &cancellables)
    }

    func initializeGame() {
        bluetoothManager.initialize()
    }

    func tryStartGame(duration: Int, difficulty: DifficultyStatus) {
        do {
            let playerId = try FirebaseManager.shared.getUserId()
            let startGameModel = StartGameModel(mode: .chrono, playerId: playerId, duration: duration, difficulty: difficulty)
            bluetoothManager.writeValue(data: startGameModel, type: .gameStart)
        } catch {
            self.gameError = .gameStartError
        }
    }
}

enum DataModelType: String {
    case connected = "CONNECTED"
    case gameStart = "GAME_START"
    case gameFinish = "GAME_FINISHED"
}
