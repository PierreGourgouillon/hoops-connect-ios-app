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
                            Text("\(game.difficulty.traduction.uppercased())")
                                .foregroundStyle(ThemeColors.primaryWhite)
                                .font(.system(size: 12))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .fontWeight(.semibold)
                                .background(
                                    RoundedCorner(radius: .infinity, corners: .allCorners)
                                        .stroke(ThemeColors.primaryWhite, lineWidth: 1)
                                        .background(
                                            ThemeColors.primaryOrange
                                                .cornerRadius(.infinity, corners: .allCorners)
                                        )
                                    )
                            Text("25 Juin")
                                .foregroundStyle(ThemeColors.primaryWhite)
                                .font(.system(size: 12))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .fontWeight(.semibold)
                                .background(
                                    RoundedCorner(radius: .infinity, corners: .allCorners)
                                        .stroke(ThemeColors.primaryWhite, lineWidth: 1)
                                        .background(
                                            ThemeColors.primaryOrange
                                                .cornerRadius(.infinity, corners: .allCorners)
                                        )
                                )
                            Spacer()
                            Text("\(game.score) pts")
                                .foregroundStyle(ThemeColors.primaryWhite)
                                .font(.system(size: 12))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .fontWeight(.semibold)
                                .background(
                                    RoundedCorner(radius: 4.0, corners: .allCorners)
                                        .stroke(ThemeColors.primaryWhite, lineWidth: 1)
                                        .background(
                                            ThemeColors.primaryOrange
                                                .cornerRadius(4, corners: .allCorners)
                                        )
                                )
                        }
                        .padding(.top)
                        Spacer()
                        Text("Mode \(game.mode.rawValue.lowercased())")
                            .foregroundStyle(ThemeColors.primaryWhite)
                            .font(.title)
                            .padding(.bottom, 40)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    .fullWidth()
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
