//
//  EditUserProfile.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

struct EditUserProfileView: View {
    @ObservedObject var viewModel: EditUserProfileViewModel = .init()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .center) {
            Text("Paramètres")
                .foregroundStyle(Color.white)
                .font(.title2)
                .fontWeight(.semibold)
            Image("basketball_ball")
                .resizable()
                .frame(width: 130, height: 130)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding(.top)

            RoundedTextField(text: $viewModel.userPseudo, imageName: "person.crop.circle", placeholder: "Pseudo")
                .padding(.top)

            RoundedTextField(text: $viewModel.userEmail, imageName: "envelope", placeholder: "Email")
                .padding(.top)

            HStack(spacing: 50) {
                Text("Homme")
                    .foregroundStyle(ThemeColors.primaryWhite)
                    .font(.system(size: 15))
                    .padding(.horizontal)
                    .padding(.vertical)
                    .fontWeight(.semibold)
                    .background(
                        RoundedCorner(radius: 10, corners: .allCorners)
                            .stroke(ThemeColors.primaryWhite, lineWidth: 3)
                            .background(
                                (viewModel.userSex == "male" ?  ThemeColors.primaryOrange : Color.clear)
                                    .cornerRadius(10, corners: .allCorners)
                            )
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.userSex = "male"
                        }
                    }

                Text("Femme")
                    .foregroundStyle(ThemeColors.primaryWhite)
                    .font(.system(size: 15))
                    .padding(.horizontal)
                    .padding(.vertical)
                    .fontWeight(.semibold)
                    .background(
                        RoundedCorner(radius: 10, corners: .allCorners)
                            .stroke(ThemeColors.primaryWhite, lineWidth: 3)
                            .background(
                                (viewModel.userSex == "female" ?  ThemeColors.primaryOrange : Color.clear)
                                    .cornerRadius(10, corners: .allCorners)
                            )
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.userSex = "female"
                        }
                    }
            }
            .padding(.top)
            Spacer()
            Button("Enregistrer") {
                dismiss()
            }
            .buttonStyle(RoundedButton(color: ThemeColors.primaryOrange))
            .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.bottom)
        .padding(.top, 30)
        .fullScreen()
        .background(ThemeColors.sheetBackground)
    }
}

struct EditUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditUserProfileView()
    }
}
