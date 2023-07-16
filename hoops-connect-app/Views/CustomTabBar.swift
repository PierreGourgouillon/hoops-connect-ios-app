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
//            Path { path in
//                path.addLines([.init(x: 0, y: 28), .init(x: 6, y: 20)])
//            }
//            .stroke(lineWidth: 1)
//            .frame(width: UIScreen.main.bounds.width, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    ZStack(alignment: .center) {
                        Image(systemName: selectedTab == tab ? fillImage : tab.defaultImage)
//                            .offset(y: selectedTab == tab ? -40 : 0)
                            .foregroundColor(tab == selectedTab ? .orange : .gray)
                            .font(.system(size: 20))
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.2)) {
                                    selectedTab = tab
                                }
                            }

//                        if selectedTab == tab {
//                            VStack(alignment: .center) {
//                                Text(tab.displayName)
//                                    .foregroundStyle(Color.orange)
//                                    .fontWeight(.semibold)
//                                    .font(.system(size: 10))
//
//                                Circle()
//                                    .frame(width: 3, height: 3)
//                                    .foregroundStyle(Color.orange)
//                            }
//                        }
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
