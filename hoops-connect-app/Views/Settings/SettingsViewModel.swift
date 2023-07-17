//
//  SettingsViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var isError: Bool = false
    @Published var settingsError: SettingsError?
    @Published var isDisconnect: Bool = false

    func logout() {
        do {
            try FirebaseManager().logout()
            isDisconnect = true
        } catch {
            isError = true
            settingsError = .logoutError
        }
    }
}

enum SettingsError {
    case logoutError

    var title: String {
        return "Erreur de déconnexion"
    }

    var message: String {
        return "Une erreur est survenue lors de la déconnexion. Veuillez réessayez."
    }
}
