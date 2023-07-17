//
//  Network+Extensions.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

import Foundation
import RetroSwift

extension Network {
    init(
        endpoint: HTTPEndpoint,
        method: HTTPMethod,
        headers: [String: String] = ["Content-Type": "application/json"]
    ) {
        self.init(url: endpoint.url ?? "", method: method, headers: headers, successStatusCodes: Set<Int>(200...209))
    }

    init(
        authenticated endpoint: HTTPEndpoint,
        method: HTTPMethod,
        headers: [String: String] = ["Content-Type": "application/json"]
    ) {
        self.init(url: endpoint.url ?? "", method: method, headers: headers, successStatusCodes: Set<Int>(200...209), requestInterceptor: JWTNetworkRequestInterceptor())
    }
}

private class JWTNetworkRequestInterceptor: NetworkRequestInterceptor {
    func intercept(_ request: inout URLRequest) async throws {
        guard let token = try? await FirebaseManager().getToken(), !token.isEmpty else {
            throw NetworkError.custom("NO_AVAILABLE_TOKEN")
        }

        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
    }
}
