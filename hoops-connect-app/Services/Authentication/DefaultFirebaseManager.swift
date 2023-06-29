//
//  DefaultFirebaseManager.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import FirebaseAuth
import Firebase

protocol FirebaseManager {
    func register(email: String, password: String) async throws
    func getToken() async throws -> String
    func login(userConnectionInformations: UserModel) async throws
    func authenticationFlow() async throws
    func logout() throws
    func getUserId() throws -> String
    func getUserEmail() throws -> String
    func sendRequestResetPasswordLink(email: String) async throws
}

class DefaultFirebaseManager: FirebaseManager {

    func authenticationFlow() async throws {
        guard FirebaseProvider.auth.currentUser != nil else { throw ApplicationStateError.notAuthenticated }
    }

    func register(email: String, password: String) async throws {
        do {
            try await FirebaseProvider.auth.createUser(withEmail: email, password: password)
        } catch {
            throw UserCreationError.internalError
        }
    }

    func login(userConnectionInformations: UserModel) async throws {
        do {
            _ = try await FirebaseProvider.auth.signIn(withEmail: userConnectionInformations.email, password: userConnectionInformations.password)
        } catch {
            throw UserCreationError.internalError
        }
    }

    func logout() throws {
        try FirebaseProvider.auth.signOut()
    }

    func getToken() async throws -> String {
        do {
            guard let user = FirebaseProvider.auth.currentUser else {
                throw APICallerError.unknownError
            }

            return try await user.getIDTokenResult(forcingRefresh: true).token
        } catch {
            throw APICallerError.unknownError
        }
    }

    func getUserId() throws -> String {
        guard let currentUser = FirebaseProvider.auth.currentUser else {
            throw APICallerError.internalServerError
        }
        return currentUser.uid
    }

    func getUserEmail() throws -> String {
        guard let currentUser = FirebaseProvider.auth.currentUser else {
            throw APICallerError.internalServerError
        }
        return currentUser.email ?? ""
    }

    func sendRequestResetPasswordLink(email: String) async throws {
        try await FirebaseProvider.auth.sendPasswordReset(withEmail: email)
    }
}
