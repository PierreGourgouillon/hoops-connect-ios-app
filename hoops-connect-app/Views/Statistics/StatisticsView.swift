//
//  StatisticsView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel

    init(viewModel: StatisticsViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            List {
                if viewModel.state == .error {
                    Text("Error")
                } else {
                    ForEach(viewModel.games, id: \.self) { game in
                        GameStatCard(game: game)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .redacted(when: viewModel.state == .loading)
                    }
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .listStyle(.plain)
            .frame(minHeight: 0, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .refreshable {
                Task {
                    await viewModel.getGames()
                }
            }
        }
        .fullScreen()
        .navigationTitle("Historique")
        .background(Color.black.opacity(0.8))
        .task {
            await viewModel.getGames()
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
