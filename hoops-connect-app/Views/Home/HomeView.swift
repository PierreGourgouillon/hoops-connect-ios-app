//
//  HomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import CoreBluetooth
import UIKit

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel = .init()
    @ObservedObject private var bluetoothManager: BluetoothManager = .init()

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Hello world")
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            bluetoothManager.initialize()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
                let data = GameModel(id: "id", date: "28 oct", score: 100, playerId: "123")
                bluetoothManager.writeValue(data: data, type: "GAME")
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
