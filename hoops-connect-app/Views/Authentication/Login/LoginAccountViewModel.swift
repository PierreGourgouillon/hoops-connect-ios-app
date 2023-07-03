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

    private var firebaseManager: FirebaseManager = .init()

    @MainActor
    func login() async {
        do {
            try await firebaseManager.login(userConnectionInformations: .init(email: email, password: password))
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
            return "Erreur lors de la création"
        }
    }

    var message: String {
        switch self {
        case .none:
            return ""
        case .loginFailed:
            return "Le pseudo n'est pas valide, il doit contenir 4 charactères minimum"
        }
    }

}
