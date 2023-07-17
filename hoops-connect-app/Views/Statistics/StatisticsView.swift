//
//  StatisticsView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject private var viewModel: StatisticsViewModel = .init()
    let game: GameModel = .init(date: "25/05/2002", score: 100, playerId: "", deviceId: "", difficulty: .easy, duration: 60, mode: .chrono)

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach((1...10), id: \.self) { _ in
                    GameStatCard(game: game)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                }
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .frame(height: UIScreen.main.bounds.height * 0.8 - 80)
            .padding(.bottom, 60)
        }
        .fullScreen()
        .navigationBarBackButtonHidden(true)
        .background(Color.black.opacity(0.8))
        .refreshable {

        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
