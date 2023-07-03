//
//  View+Extensions.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 30/06/2023.
//

import SwiftUI

extension View {
    func fullScreen() -> some View {
        frame(
            minWidth: 0,
            maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
            minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
            maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/
        )
    }

    func fullWidth() -> some View {
        frame(minWidth: 0, maxWidth: .infinity)
    }

    func backgroundRadius(radius: CGFloat, color: Color) -> some View {
        background(
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .fill(color)
        )
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }

    func customAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View {
        modifier(CustomAlert(isPresented: isPresented, title: title, message: message))
    }
}
