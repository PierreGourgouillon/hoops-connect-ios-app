//
//  ApplicationState.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI

class ApplicationState: ObservableObject {

    @Published private(set) var state: State = .loading
    let firebaseManager: FirebaseManager = .init()

    func openApp() async {
        do {
            try await firebaseManager.authenticationFlow()
            await authenticate()
        } catch {
            try? firebaseManager.logout()
            await disonnect()
        }
    }

    func authenticate() async {
        await setState(.authenticated)
    }

    func disonnect() async {
        await setState(.unauthenticated)
    }

    @MainActor
    private func setState(_ state: State) {
        withAnimation { [weak self] in
            self?.state = state
        }
    }

    enum State {
        case loading, unauthenticated, authenticated
    }
}

enum ApplicationStateError: Error {
    case notAuthenticated
}
