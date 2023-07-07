//
//  StatisticHomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 07/07/2023.
//

import SwiftUI

struct StatisticHomeView: View {
    let lineWidth: CGFloat = 35
    
    var body: some View {
        ZStack(alignment: .center) {
            Capsule(style: .circular)
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.white.opacity(0.2))
                .padding(4)

            Capsule(style: .circular)
                .trim(from: 0.50, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .padding(4)

            Capsule(style: .circular)
                .trim(from: 0.0, to: 0.20)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.pink)
                .padding(4)

            Capsule(style: .circular)
                .trim(from: 0.25, to: 0.40)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.yellow)
                .padding(4)
        }
    }
}

struct StatisticHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticHomeView()
    }
}
