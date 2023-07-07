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
            HStack {
                Text("Bluetooth state:")
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
            HStack {
                Text("Bluetooth error: ")
                switch viewModel.errorType {
                case .gameInitializeError:
                    Text("GAME INIT ERROR")
                case .gameStartError:
                    Text("GAME START ERROR")
                case .gameFinishError:
                    Text("GAME FINISH ERROR")
                case .unknownError:
                    Text("UNKNON ERROR")
                case .bluetoothDisconnected:
                    Text("DISCONNECT ERROR")
                case .none:
                    EmptyView()
                }
            }

            Button("Start Game") {
                viewModel.startGame()
            }

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.consoleChat, id: \.self) { historic in
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
        .onAppear {
            viewModel.initialize()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
