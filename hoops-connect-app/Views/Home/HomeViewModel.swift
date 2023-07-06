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
    @Published var errorType: BluetoothError?

    init(bluetoothManager: BluetoothManager = .init()) {
        self.bluetoothManager = bluetoothManager
        self.gameManager = .init(bluetoothManager: bluetoothManager)

        bluetoothManager.$state
            .sink { [weak self] in
                self?.bluetoothState = $0
            }
            .store(in: &cancellables)

        bluetoothManager.$error
            .sink { [weak self] in
                self?.isError = true
                self?.errorType = $0
            }
            .store(in: &cancellables)
    }

    func initialize() {
        bluetoothManager.initialize()
    }

    func startGame() {
        gameManager.tryStartGame()
    }
}
