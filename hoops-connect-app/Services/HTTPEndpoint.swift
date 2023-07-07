//
//  HTTPEndpoint.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

import Foundation

enum HTTPEndpoint: String {
    var baseURL: String { "https://hoops-connect-f3c543b03421.herokuapp.com/api" }

    case registerUser = "/auth/register"
    case me = "/auth/login"
    case gameFinish = "/games/finish"

    var url: String? {
        URL(string: baseURL)?.appendingPathComponent(self.rawValue).absoluteString
    }
}
