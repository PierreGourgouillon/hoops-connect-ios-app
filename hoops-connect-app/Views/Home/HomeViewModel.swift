//
//  HomeViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation
import CoreBluetooth

class HomeViewModel: ObservableObject {
    @Published var names: [String] = []

    func start() {
    }
}
