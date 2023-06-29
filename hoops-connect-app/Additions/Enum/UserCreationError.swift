//
//  UserCreationError.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import Foundation

enum UserCreationError: Error, Equatable {
    case emptyFirstname
    case emptyLastname
    case wrongEmail
    case emptyEmail
    case smallPasword
    case noUppercaseLetterPassword
    case noLowercaseLetterPassword
    case noNumberPassword
    case noSpecialCharacterPassword
    case differentPassword
    case emptyPassword
    case emptyConfirmationPassword
    case internalError
    case unknown

    var errorDescription: String? {
        switch self {
        case .emptyFirstname: return "Le prénom est vide"
        case .emptyLastname: return "Le nom est vide"
        case .wrongEmail: return "L'email invalide"
        case .emptyEmail: return "L'email est vide"
        case .smallPasword: return "Le motde passe est trop court"
        case .noUppercaseLetterPassword: return "Le mot de passe ne comporte pas de majuscule"
        case .noLowercaseLetterPassword: return "Le mot de passe ne comporte pas de minuscule"
        case .noNumberPassword: return "Le mot de passe ne comporte pas de chiffre"
        case .noSpecialCharacterPassword: return "Le mot de passe ne comporte pas de caractère spécial"
        case .differentPassword: return "Les mots de passes ne sont pas identiques"
        case .emptyPassword: return "Le mot de passe est vide"
        case .emptyConfirmationPassword: return "La confirmation du mot de passe est vide"
        case .internalError: return "Une erreur interne"
        case .unknown: return "Erreur inconnue"
        }
    }
}
