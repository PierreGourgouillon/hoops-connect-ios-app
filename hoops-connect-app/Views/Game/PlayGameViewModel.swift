//
//  HomeViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation
import CoreBluetooth
import Combine

class PlayGameViewModel: ObservableObject {
    private var bluetoothManager: BluetoothManager
    private var gameManager: GameManager
    private var cancellables = Set<AnyCancellable>()

    @Published var bluetoothState: BluetoothState = .initialize
    @Published var isError: Bool = false
    @Published var gameError: GameError?
    @Published var isGameStart: Bool = false

    init(bluetoothManager: BluetoothManager = .init()) {
        self.bluetoothManager = bluetoothManager
        self.gameManager = .init(bluetoothManager: bluetoothManager)


        handleBluetoothState()
    }

    func handleBluetoothState() {
        bluetoothManager.$state
            .sink { [weak self] state in
                guard let self else { return }

                if state == .connected || state == .scanning {
                    resetGameError()
                }
                 self.bluetoothState = state
            }
            .store(in: &cancellables)
    }

    func initialize() {
        bluetoothManager.initialize()
    }

    func startGame() {
        do {
//            resetGameError()
//            try gameManager.startGame(duration: 60, difficulty: .easy)
            isGameStart = true
        } catch {
            self.isError = true
            self.gameError = .gameStartError
        }
    }

    func resetGameError() {
        isError = false
        gameError = nil
    }
}
