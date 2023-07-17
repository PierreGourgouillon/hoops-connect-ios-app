//
//  SettingsView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var isShowEditUserProfile: Bool = false
    @ObservedObject var viewModel: SettingsViewModel = .init()

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Salut, ")
                            .fontWeight(.light)
                        Text("Pierre")
                            .fontWeight(.semibold)
                    }
                    Text("Gourgouillon")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(ThemeColors.primaryWhite)
                .font(.title)
                Spacer()
                Image("basketball_ball")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.top)
            }
            .padding(.horizontal)
            VStack {
                Capsule()
                        .fill(Color.secondary)
                        .frame(width: 30, height: 3)
                        .padding(10)
                Button("Modifier les informations") {
                    isShowEditUserProfile = true
                }
                .buttonStyle(RoundedButton(color: ThemeColors.primaryOrange))
                .foregroundColor(.white)
                .padding(.top)
                Spacer()
                Button("Déconnexion") {
                    viewModel.logout()
                }
                .buttonStyle(RoundedButton(color: Color.red))
                .foregroundColor(.white)
            }
            .padding(.bottom, 100)
            .padding(.horizontal)
            .fullWidth()
            .frame(height: UIScreen.main.bounds.height * 0.8)
            .background(ThemeColors.secondaryGray)
            .cornerRadius(20, corners: .topLeft)
            .cornerRadius(20, corners: .topRight)
        }
        .fullScreen()
        .navigationBarBackButtonHidden(true)
        .background(Color.black.opacity(0.8))
        .sheet(isPresented: $isShowEditUserProfile, content: {
            EditUserProfileView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
        .navigationDestination(isPresented: $viewModel.isDisconnect) {
            AuthenticationView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
