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
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(bluetoothManager.consoleHistoric, id: \.self) { historic in
                        HStack {
                            Text("-> \(historic)")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .fullScreen()
            .background(Color.black)
        }
        .navigationBarBackButtonHidden(true)
        .fullScreen()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let startGame = StartGameModel(mode: .chrono, playerId: "g16SLHuJylhpCePY5T6WGz4EZLa2", duration: 60, difficulty: .easy)
                    bluetoothManager.writeValue(data: startGame, type: "START_GAME")
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundStyle(.white, .black)
                }
            }
        }
        .onAppear {
            bluetoothManager.initialize()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
