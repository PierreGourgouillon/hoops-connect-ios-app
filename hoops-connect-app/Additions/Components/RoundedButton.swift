//
//  RoundedButton.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 30/06/2023.
//

import SwiftUI

struct RoundedButton: ButtonStyle {
    let color: Color
    let radius: CGFloat
    let fontSize: CGFloat

    init(color: Color, radius: CGFloat = 12, fontSize: CGFloat = 18) {
        self.color = color
        self.radius = radius
        self.fontSize = fontSize
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .font(.system(size: fontSize))
                .fontWeight(.semibold)
            Spacer()
        }
        .padding()
        .background(
            color.cornerRadius(radius)
                .opacity(configuration.isPressed ? 0.6 : 1)
        )
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Get started", action: {})
            .buttonStyle(RoundedButton(color: .yellow))
    }
}
