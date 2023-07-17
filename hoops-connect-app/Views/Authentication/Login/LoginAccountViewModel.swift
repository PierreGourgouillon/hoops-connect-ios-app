//
//  LoginAccountViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

import SwiftUI

class LoginAccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isError: Bool = false
    @Published var error: LoginAccountError = .none
    @Published var isNavigateToHome: Bool = false

    let firebaseManager: FirebaseManager = .init()

    @MainActor
    func login() async {
        do {
            try await firebaseManager.login(userConnectionInformations: .init(email: email, password: password))
            isNavigateToHome = true
        } catch (_) {
            withAnimation {
                isError = true
                error = .loginFailed
            }
        }
    }
}

enum LoginAccountError {
    case none
    case loginFailed

    var title: String {
        switch self {
        case .none:
            return ""
        case .loginFailed:
            return "Erreur lors de la connexion"
        }
    }

    var message: String {
        switch self {
        case .none:
            return ""
        case .loginFailed:
            return "Veuillez vérifier que les données saisies sont correctes"
        }
    }
    // TODO: Faire le SecureField demain et mettre correctement les textfields (Plus de maj etc)
}
