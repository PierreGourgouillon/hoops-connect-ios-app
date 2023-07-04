//
//  BodyBluetoothModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation

struct BodyBluetoothModel<T: Codable>: Codable {
    let type: String
    let data: T
}
