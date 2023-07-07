//
//  GameModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 05/07/2023.
//

import Foundation

struct GameModel: Codable {
    let date: String
    let score: Int
    let playerId: String
    let deviceId: String
    let difficulty: DifficultyStatus
    let duration: Int
    let mode: GameModeStatus

    func toDTO() -> GameDTO {
        GameDTO(date: date, score: score, deviceId: deviceId, difficulty: difficulty, duration: duration, mode: mode)
    }
}
