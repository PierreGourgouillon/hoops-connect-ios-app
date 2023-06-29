//
//  HoopsConnectApp.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import netfox

@main
struct AlcallApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject private var applicationState: ApplicationState
    init() {
        self.applicationState = ApplicationState(firebaseManager: DefaultFirebaseManager())
    }

    var body: some Scene {
        WindowGroup {
//            ContentView(applicationState: applicationState)
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseProvider.configureApp()

        #if DEBUG
        NFX.sharedInstance().start()
        #endif

        return true
    }
}
