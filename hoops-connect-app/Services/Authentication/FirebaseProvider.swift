//
//  FirebaseProvider.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import Firebase
import FirebaseAuth

public final class FirebaseProvider {

    static func configureApp() {
        FirebaseApp.configure()
    }

    static public var auth: Auth {
        Auth.auth()
    }
}
