//
//  GameService.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 07/07/2023.
//

import Foundation
import RetroSwift

struct GameService {
    @Network<Void>(authenticated: .gameFinish, method: .POST)
    var gameFinish
}
