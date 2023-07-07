//
//  HomeViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation
import CoreBluetooth
import Combine

class HomeViewModel: ObservableObject {
    private var bluetoothManager: BluetoothManager
    private var gameManager: GameManager
    private var cancellables = Set<AnyCancellable>()

    @Published var bluetoothState: BluetoothState = .initialize
    @Published var isError: Bool = false
    @Published var errorType: GameError?
    @Published var consoleChat: [String] = []

    init(bluetoothManager: BluetoothManager = .init()) {
        self.bluetoothManager = bluetoothManager
        self.gameManager = .init(bluetoothManager: bluetoothManager)

        bluetoothManager.$state
            .sink { [weak self] in
                if $0 == .connected || $0 == .scanning {
                    self?.isError = false
                    self?.errorType = nil
                }
                self?.bluetoothState = $0
            }
            .store(in: &cancellables)

        gameManager.$gameError
            .sink { [weak self] in
                self?.isError = true
                self?.errorType = $0
            }
            .store(in: &cancellables)

        gameManager.$consoleChat
            .sink { [weak self] in
                self?.consoleChat = $0
            }
            .store(in: &cancellables)
    }

    func initialize() {
        gameManager.initializeGame()
    }

    func startGame() {
        isError = false
        errorType = nil
        gameManager.tryStartGame(duration: 60, difficulty: .easy)
    }
}
