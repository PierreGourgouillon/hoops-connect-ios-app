//
//  GameModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation

struct GameModel: Codable {
    let id: String
    let date: String
    let score: Int
    let playerId: String
}


// TODO: au lancement de game, envoyer le Pseudo (START_GAME)
