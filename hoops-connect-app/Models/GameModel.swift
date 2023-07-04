//
//  GameModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 05/07/2023.
//

import Foundation

struct GameModel: Codable {
    let id: String
    let date: String
    let score: Int
    let playerId: String
}
