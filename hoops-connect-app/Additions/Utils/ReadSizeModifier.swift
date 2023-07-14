//
//  ReadSizeModifier.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 14/07/2023.
//

import SwiftUI

struct ReadSizeModifier: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content.background(GeometryReader(content: setSize(_:)))
    }

    private func setSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.size = proxy.size
        }

        return Color.clear
    }
}
