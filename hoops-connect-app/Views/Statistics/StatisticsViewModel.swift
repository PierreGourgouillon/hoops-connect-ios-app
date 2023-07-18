//
//  StatisticsViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import Foundation

class StatisticsViewModel: ObservableObject {
    private var gameService: GameService = .init()
    @Published var games: [GameModel] = [.gamePlaceholder, .gamePlaceholder]
    @Published var state: StatisticsState = .loading

    @MainActor
    func getGames() async {
        do {
            state = .loading
            guard let gamesResult = try await gameService.games.call().data else { return }

            self.games = gamesResult
            state = .listingGames
        } catch {
            print(error.localizedDescription)
        }
    }

    enum StatisticsState {
        case loading
        case listingGames
        case error
    }
}
