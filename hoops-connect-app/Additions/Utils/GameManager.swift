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
    private var gameService: GameService = .init()

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

        bluetoothManager.$latestData
            .sink { [weak self] in
                guard let gameModel = $0, let self = self else {
                    return
                }

                Task {
                    await self.endGame(gameModel: gameModel)
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

    func endGame(gameModel: GameModel) async {
        do {
            try await gameService.gameFinish.call(body: gameModel.toDTO())
            print("END GAME")
        } catch {

        }
    }
}

enum DataModelType: String {
    case connected = "CONNECTED"
    case gameStart = "GAME_START"
    case gameFinish = "GAME_FINISHED"
}
