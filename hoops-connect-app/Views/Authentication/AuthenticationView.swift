//
//  AuthenticationView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI

struct AuthenticationView: View {

    @State private var navigateToCreateAccount = false
    @State private var navigateToLoginAccount = false

    var imageCard: some View {
        VStack {
            Image("hoops_connect_logo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
        }
        .fullWidth()
        .padding(.vertical, 60)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)
        .padding(.vertical, 20)
    }

    var bottomView: some View {
        Group {
            Button("Commencer") {
                navigateToCreateAccount = true
            }
                .buttonStyle(RoundedButton(color: .orange, radius: 12, fontSize: 18))
                .foregroundColor(.white)
            HStack(alignment: .center) {
                Spacer()
                Text("Vous avez déjà un compte ?")
                    .lineLimit(1)
                    .foregroundColor(.white)
                Button("Se connecter") {
                    navigateToLoginAccount = true
                }
                .fontWeight(.medium)
                .foregroundColor(.orange)
                Spacer()
            }
            .padding(.top, 6)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            imageCard
            Text("Bienvenue sur Hoops Connect")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .foregroundColor(.white)
            Spacer()
            bottomView
        }
        .padding(.horizontal, 20)
        .fullScreen()
        .background(.black.opacity(0.8))
        .navigationDestination(isPresented: $navigateToCreateAccount) {
            CreationAccountView()
        }
        .navigationDestination(isPresented: $navigateToLoginAccount) {
            LoginAccountView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
