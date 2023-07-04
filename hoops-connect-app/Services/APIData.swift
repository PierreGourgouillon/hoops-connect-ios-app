//
//  APIData.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 03/07/2023.
//

struct APIData<T: Decodable>: Decodable {
    let data: T
}
