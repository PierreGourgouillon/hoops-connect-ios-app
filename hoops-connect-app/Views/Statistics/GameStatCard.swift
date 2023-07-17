//
//  GameStatCard.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

struct GameStatCard: View {
    let game: GameModel

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("basketball_ball")
                    .resizable()
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .fullScreen()

                LinearGradient(colors: [Color.black.opacity(0.2), Color.black.opacity(0.3), Color.black.opacity(0.5)], startPoint: .top, endPoint: .center)

                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(game.difficulty.rawValue.lowercased())")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 12))
                                .padding(.horizontal, 7)
                                .background(
                                    Color.orange
                                        .cornerRadius(20, corners: .allCorners)
                                )
                            Spacer()
                        }
                        Spacer()
                        Text("\(game.mode.rawValue.capitalized)")
                            .foregroundStyle(Color.white)
                    }
                    .padding(.horizontal)
                    .frame(width: proxy.frame(in: .local).width * 0.7)
                    .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background(Color.red)

                    VStack(alignment: .center) {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundStyle(Color.white.opacity(0.5))
                                .frame(width: 80)
                            Text("\(game.score) pts")
                        }
                    }
                    .frame(width: proxy.frame(in: .local).width * 0.3)
                    .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }
            }
        }
        .frame(height: 150)
        .cornerRadius(10, corners: .allCorners)
    }
}

struct GameStatCard_Previews: PreviewProvider {
    static var previews: some View {
        GameStatCard(game: .init(date: "25/05/2002", score: 100, playerId: "", deviceId: "", difficulty: .easy, duration: 60, mode: .chrono))
            .padding()
    }
}
