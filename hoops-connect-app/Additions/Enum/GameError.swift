//
//  GameError.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 16/07/2023.
//

import Foundation

enum GameError: Error {
    case bluetoothDisconnected
    case gameInitializeError
    case gameStartError
    case gameFinishError
    case unknownError

    var title: String {
        switch self {
        case .bluetoothDisconnected:
            return "Bluetooth déconnecté"
        case .gameInitializeError:
            return "Erreur d'initialisation"
        case .gameStartError:
            return "Erreur de démarrage du jeu"
        case .gameFinishError:
            return "Erreur de fin de jeu"
        case .unknownError:
            return "Erreur inconnue"
        }
    }

    var message: String {
        switch self {
        case .bluetoothDisconnected:
            return "La communication Bluetooth avec le panier de basket a été perdue."
        case .gameInitializeError:
            return "Une erreur est survenue lors de l'initialisation du jeu. Veuillez réessayer."
        case .gameStartError:
            return "Impossible de démarrer le jeu. Vérifiez la connexion avec le panier de basket."
        case .gameFinishError:
            return "Une erreur est survenue lors de la fin du jeu. Veuillez réessayer."
        case .unknownError:
            return "Une erreur inconnue s'est produite. Veuillez redémarrer l'application."
        }
    }
}
