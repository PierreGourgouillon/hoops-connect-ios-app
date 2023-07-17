//
//  HomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import CoreBluetooth

struct HomeView: View {
    @State private var tabSelected: Tab = .house
    @State private var sizeTabBar: CGSize = CGSize()

    init() {
        UITabBar.appearance().isHidden = true
    }

    var navTitle: String {
        switch tabSelected {
        case .gearshape:
            return ""
        case .house:
            return "Jouer"
        case .chart:
            return "Historique"
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    TabView(selection: $tabSelected) {
                        switch tabSelected {
                        case .gearshape:
                            SettingsView()
                        case .house:
                            PlayGameView()
                        case .chart:
                            StatisticsView()
                        }
                    }
                }
                .padding(.bottom, sizeTabBar.height)
                CustomTabBar(selectedTab: $tabSelected)
                    .readSize($sizeTabBar)
            }
//            .customAlert(
//                isPresented: $playGameViewModel.isError,
//                title: playGameViewModel.gameError?.title ?? "",
//                message: playGameViewModel.gameError?.message ?? ""
//            )
//            .customAlert(
//                isPresented: $settingsViewModel.isError,
//                title: settingsViewModel.settingsError?.title ?? "",
//                message: settingsViewModel.settingsError?.message ?? ""
//            )
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
