//
//  LoginAccountView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 30/06/2023.
//

import SwiftUI

struct LoginAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: LoginAccountViewModel = .init()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var imageCard: some View {
        ZStack(alignment: .center) {
            VStack { }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)

            Image("basketball_player_dunk")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
        }
        .fullWidth()
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }

    var topSection: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Si tu veux dunker comme Kobe il faut d'abord que tu te connecte ! On a hâte de te voir sur le terrain")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.subheadline)
        }
        .padding(.top, UIScreen.main.bounds.height*12/100)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            topSection
            imageCard
            VStack(alignment: .leading) {
                Text("Information")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top)
                RoundedTextField(text: $viewModel.email, imageName: "envelope", placeholder: "Email")
                RoundedTextField(text: $viewModel.password, imageName: "shield", placeholder: "Mot de passe")
                    .padding(.top, 5)
                    .padding(.bottom, 30)
            }
            Button("Se connecter") {
                Task {
                    await viewModel.login()
                }
            }
            .buttonStyle(RoundedButton(color: .orange))
            .foregroundColor(.white)
            .padding(.top)

            NavigationLink(destination: HomeView(), isActive: $viewModel.isNavigateToHome) { EmptyView() }
        }
        .fullScreen()
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .background(.black.opacity(0.8))
        .navigationTitle(Text("La connexion"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward.circle")
                        .font(.system(size: 25))
                        .foregroundStyle(.white, .orange)
                }
            }
        }
        .customAlert(
            isPresented: $viewModel.isError,
            title: viewModel.error.title,
            message: viewModel.error.message
        )
    }
}

struct LoginAccountView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAccountView()
    }
}
