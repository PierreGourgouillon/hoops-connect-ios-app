//
//  RoundedTextField.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 30/06/2023.
//

import SwiftUI

struct RoundedTextField: View {
    @Binding var text: String

    var imageName: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray.opacity(0.8))
                .fontWeight(.semibold)
                .font(.system(size: 22))
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white))
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .fill(.gray.opacity(0.2))
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .stroke(.white.opacity(0.5), lineWidth: 2)
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField(text: .constant(""), imageName: "envelope", placeholder: "Email")
    }
}
