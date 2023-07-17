//
//  PlayGameView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 14/07/2023.
//

import SwiftUI

struct PlayGameView: View {
    @ObservedObject var viewModel: PlayGameViewModel = .init()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func headerView(proxy: GeometryProxy) -> some View {
        return VStack {
            ZStack {
                StatisticHomeView()
                .frame(width: proxy.size.width * 0.6, height: 340)

                Image("basketball_player_home")
                    .resizable()
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width * 0.6, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 150)
                    .padding(.leading, 40)
            }
            .offset(y: -90)
        }
        .frame(width: proxy.size.width * 0.6, height: 340)
    }

    func statisticContainer(title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .foregroundStyle(color)
                .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top, 5)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.title)
                    .fontWeight(.heavy)
            }
        }
        .foregroundStyle(.white)
    }

    var buttonState: some View {
        var buttonName: String
        switch viewModel.bluetoothState {
        case .scanning:
            buttonName = "En recherche de panier"
        case .connected:
            buttonName = "Lancer une partie"
        default:
            buttonName = "Activer le bluetooth"
        }

        return Button(buttonName) {
            if viewModel.bluetoothState == .connected {
                viewModel.startGame()
            }
        }
        .buttonStyle(
            RoundedButton(
                color: viewModel.bluetoothState == .connected ? .orange : .gray,
                fontSize: viewModel.bluetoothState == .connected ? 18 : 16
            )
        )
        .foregroundStyle(.white)
        .disabled(viewModel.bluetoothState != .connected)
    }

    var disconnectButton: some View {
        Button("Arrêter la partie") {
            viewModel.isGameStart = false
        }
        .buttonStyle(
            RoundedButton(
                color: .red,
                fontSize: 18
            )
        )
        .foregroundStyle(.white)
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                if viewModel.isGameStart {
                    TimerStartGameView()
                    disconnectButton
                        .frame(width: proxy.size.width * 0.5)
                        .padding(.vertical, 50)
                } else {
                    headerView(proxy: proxy)
                    HStack {
                        statisticContainer(title: "Matchs", description: "25 %", color: .blue)
                        Spacer()
                        statisticContainer(title: "PPG", description: "25 %", color: .yellow)
                        Spacer()
                        statisticContainer(title: "Score", description: "25 %", color: .pink)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, -25)

                    buttonState
                        .frame(width: proxy.size.width * 0.5)
                        .padding(.vertical, 50)
                }
            }
            .fullScreen()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Jouer")
            .background(ThemeColors.primaryBackground)
        }
        .onAppear {
            viewModel.initialize()
        }
    }
}

struct PlayGame_Previews: PreviewProvider {
    static var previews: some View {
        PlayGameView()
    }
}
