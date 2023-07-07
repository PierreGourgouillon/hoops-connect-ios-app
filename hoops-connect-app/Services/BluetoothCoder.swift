//
//  BluetoothCoder.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 04/07/2023.
//

import Foundation

class BluetoothCoder {
    let decoder: JSONDecoder = .init()
    let encoder: JSONEncoder = .init()

    func unParseData<T: Decodable>(data: Data) -> T? {
        do {
            let receivedData = try decoder.decode(T.self, from: data)
            return receivedData
        } catch let decodeError {
            print("Failed to decode \(T.self): \(decodeError)")
            return nil
        }
    }

    func parseData<T: Encodable>(data: T) -> String? {
        guard let jsonData = try? JSONEncoder().encode(data),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }

        return jsonString
    }
}
