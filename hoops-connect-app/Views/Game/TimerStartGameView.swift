//
//  TimerStartGameView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 16/07/2023.
//

import SwiftUI

struct TimerStartGameView: View {
    @State private var countdown = 3
    @State private var countDownGame = 60
    @State private var progress: CGFloat = 1.0
    var body: some View {
        VStack {
            Text(countdown == 0 ? "" : "\(countdown)")
                .foregroundStyle(.white)
                .font(.system(size: 45))
                .fontWeight(.black)
                .padding()

            if countdown == 0 {
                ZStack(alignment: .center) {
                    Capsule(style: .circular)
                        .stroke(lineWidth: 15)
                        .foregroundColor(.white.opacity(0.2))
                        .padding(4)

                    Text("\(countDownGame)")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()

                    Capsule(style: .circular)
                        .trim(from: 0.0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.orange)
                        .padding(4)
                        .rotationEffect(.degrees(-90))
                }
                .frame(width: 200, height: 200)
            }
        }
        .fullScreen()
        .onAppear {
            startCountdown()
        }
    }

    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation(.easeIn) {
                countdown -= 1
            }

            if countdown == 0 {
                timer.invalidate()
                gameTimer()
            }
        }
    }

    private func gameTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation(.easeIn) {
                countDownGame -= 1
                progress = CGFloat(countDownGame) / 60.0
            }

            if countDownGame == 0 {
                timer.invalidate()
            }
        }
    }
}

struct TimerStartGameView_Previews: PreviewProvider {
    static var previews: some View {
        TimerStartGameView()
    }
}
