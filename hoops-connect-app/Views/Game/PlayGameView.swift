//
//  PlayGameView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 14/07/2023.
//

import SwiftUI

struct PlayGameView: View {
    @ObservedObject private var viewModel: PlayGameViewModel = .init()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                headerView(proxy: proxy)
                HStack {
                    statisticContainer(title: "Gifts", description: "25 %", color: .blue)
                    Spacer()
                    statisticContainer(title: "Income", description: "25 %", color: .yellow)
                    Spacer()
                    statisticContainer(title: "Expenses", description: "25 %", color: .pink)
                }
                .padding(.horizontal, 30)
                .padding(.top, -25)

                Button("Lancer une partie") {
                    viewModel.startGame()
                }
                .buttonStyle(RoundedButton(color: .orange))
                .foregroundStyle(.white)
                .frame(width: proxy.size.width * 0.5)
                .padding(.vertical, 50)
            }
            .fullScreen()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Jouer")
            .background(Color.black.opacity(0.8))
        }
    }

    func headerView(proxy: GeometryProxy) -> some View {
        return VStack {
            ZStack {
                StatisticHomeView()
                .frame(width: proxy.size.width * 0.7, height: 420)

                Image("basketball_player_home")
                    .resizable()
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width * 0.7, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 150)
                    .padding(.leading, 40)
            }
        }
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
}

struct PlayGame_Previews: PreviewProvider {
    static var previews: some View {
        PlayGameView()
    }
}
