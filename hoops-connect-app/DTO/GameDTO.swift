//
//  GameDTO.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 07/07/2023.
//

import Foundation

struct GameDTO: Codable {
    let date: String
    let score: Int
    let deviceId: String
    let difficulty: DifficultyStatus
    let duration: Int
    let mode: GameModeStatus
}
