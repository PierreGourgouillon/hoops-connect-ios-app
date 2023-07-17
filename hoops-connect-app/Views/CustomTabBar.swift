//
//  CustomTabBar.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 14/07/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case gearshape
    case house
    case chart

    var defaultImage: String {
        switch self {
        case .gearshape:
            "gearshape"
        case .house:
            "house"
        case .chart:
            "chart.bar"
        }
    }

    var displayName: String {
        switch self {
        case .gearshape:
            "Settings"
        case .house:
            "Play"
        case .chart:
            "Stats"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    private var fillImage: String {
        selectedTab.defaultImage + ".fill"
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    ZStack(alignment: .center) {
                        Image(systemName: selectedTab == tab ? fillImage : tab.defaultImage)
                            .foregroundColor(tab == selectedTab ? ThemeColors.primaryOrange : .gray)
                            .font(.system(size: 20))
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.2)) {
                                    selectedTab = tab
                                }
                            }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 7)
            .background(Color.black.opacity(0.7))
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}
