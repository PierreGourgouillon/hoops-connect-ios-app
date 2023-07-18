//
//  HomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import CoreBluetooth

struct HomeView: View {
    @State var navigateToSettings = false
    @State var navigateToStatistics = false

    var body: some View {
        NavigationView {
            PlayGameView()
        }
        .navigationTitle("Jouer")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigateToSettings = true
                } label: {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigateToStatistics = true
                } label: {
                    Image(systemName: "chart.bar")
                        .foregroundStyle(.white)
                }
            }
        }
        .sheet(isPresented: $navigateToSettings, content: {
            SettingsView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
        .navigationDestination(isPresented: $navigateToStatistics) {
            StatisticsView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
