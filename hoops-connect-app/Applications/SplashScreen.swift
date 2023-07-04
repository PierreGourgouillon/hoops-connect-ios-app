//
//  ContentView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    let applicationState: ApplicationState

    var body: some View {
        NavigationStack {
            if isActive {
                if applicationState.state == .authenticated {
                    HomeView()
                } else if applicationState.state == .unauthenticated {
                    AuthenticationView()
                }
            } else {
                VStack {

                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
                .task {
                    await applicationState.openApp()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            applicationState: .init()
        )
    }
}
