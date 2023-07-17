//
//  EditUserProfileViewModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 17/07/2023.
//

import SwiftUI

class EditUserProfileViewModel: ObservableObject {
    @Published var userPseudo: String = ""
    @Published var userEmail: String = ""
    @Published var userSex: String = ""
}
