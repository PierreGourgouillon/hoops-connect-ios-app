//
//  CreationAccountViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 01/07/2023.
//

import SwiftUI

class CreationAccountViewModel: ObservableObject {
    @Published var pseudo: String = ""
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var userSex: String = ""
    @Published var isError: Bool = false
    @Published var error: CreationAccountError = .none

    private var firebaseManager: FirebaseManager = .init()
    private var userService: UserService = .init()

    @MainActor
    func createAccount() async {
        do {
            try await firebaseManager.register(email: userEmail, password: userPassword)
            try await userService.register.call(body: UserDTO(email: userEmail, pseudo: pseudo, sex: userSex))
        } catch (_) {
            withAnimation {
                isError = true
                error = .creation
            }
        }
    }

    @MainActor
    func verifyStepper() -> Bool {
        guard pseudo.count >= 4 else {
            withAnimation {
                isError = true
                error = .invalidPseudo
            }
            return false
        }

        guard !userSex.isEmpty else {
            withAnimation {
                isError = true
                error = .invalidSex
            }
            return false
        }

        return true
    }
}

enum CreationAccountError {
    case none
    case invalidPseudo
    case invalidSex
    case creation

    var title: String {
        switch self {
        case .none:
            return ""
        case .invalidPseudo:
            return "Pseudo invalide"
        case .invalidSex:
            return "Sexe invalide"
        case .creation:
            return "Erreur lors de la création"
        }
    }

    var message: String {
        switch self {
        case .none:
            return ""
        case .invalidPseudo:
            return "Le pseudo n'est pas valide, il doit contenir 4 charactères minimum"
        case .invalidSex:
            return "Le sexe n'a pas été renseigné, veuillez choisir une image"
        case .creation:
            return "Une erreur est survenue lors de la création du compte, veuillez vérifier vos données"
        }
    }
}
