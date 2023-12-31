//
//  StartGameModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 06/07/2023.
//

import Foundation

struct StartGameModel: Encodable {
    let mode: GameModeStatus
    let playerId: String
    let duration: Int
    let difficulty: DifficultyStatus
}

enum GameModeStatus: String, Codable {
    case chrono = "CHRONO"
}

enum DifficultyStatus: String, Codable {
    case easy = "EASY"
    case medium = "MEDIUM"
    case hardcore = "HARDCORE"
    case ultime = "ULTIME"

    var traduction: String {
        switch self {
        case .easy:
            return "facile"
        case .medium:
            return "moyen"
        case .hardcore:
            return "difficile"
        case .ultime:
            return "ultime"
        }
    }
}
