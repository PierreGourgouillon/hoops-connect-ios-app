//
//  HomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import CoreBluetooth

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel = .init()

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            switch viewModel.bluetoothState {
            case .initialize:
                Text("Initialize")
            case .scanning:
                Text("Scanning...")
            case .centralPowerOff:
                Text("Power OFF")
            case .connected:
                Text("Connected")
            case .disconnect:
                Text("Disconnected")
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.initialize()
//            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
//                let data = GameModel(id: "id", date: "28 oct", score: 100, playerId: "123")
//                viewModel.bluetoothManager.writeValue(data: data, type: "GAME")
//            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
