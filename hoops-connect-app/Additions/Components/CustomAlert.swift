//
//  CustomAlert.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

import SwiftUI

struct CustomAlert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String

    @Environment(\.safeAreaInsets) private var safeAreaInsets
    let height: CGFloat = 150

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .padding(.top, safeAreaInsets.top)
                .padding(.bottom, safeAreaInsets.bottom)

            if isPresented {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(message)
                        .foregroundColor(.white)
                }
                .fullWidth()
                .frame(height: height)
                .background(Color.red)
                .cornerRadius(20, corners: [.topRight, .topLeft])
                .transition(isPresented ? .move(edge: .bottom) : .move(edge: .top))
                .offset(y: geo.size.height - height)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                isPresented = false
            }
        }
        .onChange(of: isPresented) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        }
    }
}
