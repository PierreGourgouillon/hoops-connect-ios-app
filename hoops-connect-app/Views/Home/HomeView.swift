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

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TabView(selection: $tabSelected) {
                    switch tabSelected {
                    case .gearshape:
                        Text("Gear")
                    case .house:
                        PlayGameView()
                    case .chart:
                        Text("Chart")
                    }
                }
            }
            .padding(.bottom, sizeTabBar.height)
            CustomTabBar(selectedTab: $tabSelected)
                .readSize($sizeTabBar)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
