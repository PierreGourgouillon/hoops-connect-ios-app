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
    @ObservedObject var playGameViewModel: PlayGameViewModel = .init()

    init() {
        UITabBar.appearance().isHidden = true
    }

    var navTitle: String {
        switch tabSelected {
        case .gearshape:
            return "Settings"
        case .house:
            return "Jouer"
        case .chart:
            return "Statistiques"
        }
    }

    var body: some View {
        NavigationView { // Ajouter la NavigationView ici
            ZStack(alignment: .bottom) {
                VStack {
                    TabView(selection: $tabSelected) {
                        switch tabSelected {
                        case .gearshape:
                            Text("Gear")
                        case .house:
                            PlayGameView(viewModel: playGameViewModel)
                        case .chart:
                            StatisticsView()
                        }
                    }
                }
                .padding(.bottom, sizeTabBar.height)
                CustomTabBar(selectedTab: $tabSelected)
                    .readSize($sizeTabBar)
            }
            .customAlert(
                isPresented: $playGameViewModel.isError,
                title: playGameViewModel.gameError?.title ?? "",
                message: playGameViewModel.gameError?.message ?? ""
            )
            .navigationBarBackButtonHidden(true)
        }
        .navigationTitle(navTitle)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
