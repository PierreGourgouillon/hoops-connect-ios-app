//
//  UserService.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

import RetroSwift

struct UserService {
    @Network<Void>(authenticated: .registerUser, method: .POST)
    var register

    @Network<UserDTO>(authenticated: .me, method: .GET)
    var me
}
