//
//  CreationAccountView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 30/06/2023.
//

import SwiftUI

struct CreationAccountView: View {

    @State private var index: Int = 0

    @ObservedObject private var viewModel: CreationAccountViewModel = .init()
    @State private var isNavigateToHome: Bool = false

    var firstStep: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                ZStack(alignment: .bottom) {
                    VStack { }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                        .background(viewModel.userSex == "female" ? .orange : Color.gray.opacity(0.5))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)

                    Image("basketball_female")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width/3, height: 130)
                }
                .onTapGesture {
                    withAnimation(.easeOut) {
                        viewModel.userSex = "female"
                    }
                }

                ZStack(alignment: .bottom) {
                    VStack { }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                        .background(viewModel.userSex == "male" ? .orange : Color.gray.opacity(0.5))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)

                    Image("basketball_male")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width/3, height: 150)
                }
                .onTapGesture {
                    withAnimation(.easeOut) {
                        viewModel.userSex = "male"
                    }
                }
            }
            Text("Create your perfect profile, first choose a gender and come up with your nickname")
                .foregroundColor(.white)
                .padding(.top)
            RoundedTextField(text: $viewModel.pseudo, imageName: "person.crop.circle", placeholder: "Pseudo")
                .padding(.top)
            Text("Minimum 4 charactères")
                .foregroundColor(.gray)
                .padding(.top, 5)
        }
    }

    var secondStep: some View {
        VStack(alignment: .leading) {
            Text("Create your perfect profile, first choose a gender and come up with your nickname")
                .foregroundColor(.white)
                .padding(.top)

            Text("Information")
                .foregroundColor(.white)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(.top)
            RoundedTextField(text: $viewModel.userEmail, imageName: "envelope", placeholder: "Email")
            RoundedTextField(text: $viewModel.userPassword, imageName: "shield", placeholder: "Mot de passe")
                .padding(.top)
        }
    }

    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                HStack {
                    Text("Étape")
                        .foregroundColor(.gray.opacity(0.7))
                    Text("\(index + 1) sur 2")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }
                StepperView(numberOfStep: 2, currentIndex: $index)
                Text("Création du profil")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                switch index {
                case 0:
                    firstStep
                case 1:
                    secondStep
                default:
                    EmptyView()
                }
            }
            Spacer()
            Button(index == 0 ? "Prochaine étape" : "Créer le compte") {
                guard index < 1 else {
                    Task {
                        await viewModel.createAccount()
                        isNavigateToHome = true
                    }
                    return
                }
                withAnimation {
                    if viewModel.verifyStepper() {
                        index += 1
                    }
                }
            }
            .buttonStyle(RoundedButton(color: ThemeColors.primaryOrange))
            .foregroundColor(.white)

            NavigationLink(destination: HomeView(), isActive: $isNavigateToHome) { EmptyView() }
        }
        .padding(.horizontal)
        .background(.black.opacity(0.8))
        .navigationBarBackButtonHidden(true)
        .customAlert(
            isPresented: $viewModel.isError,
            title: viewModel.error.title,
            message: viewModel.error.message
        )
    }
}

struct CreationAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreationAccountView()
    }
}
