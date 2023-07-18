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
    @State private var size = 0.8
    @State private var opacity = 0.5

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
                    Image("hoops_connect_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .foregroundColor(ThemeColors.primaryBackground)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1
                            }
                        }
                }
                .fullScreen()
                .background(ThemeColors.primaryBackground)
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
