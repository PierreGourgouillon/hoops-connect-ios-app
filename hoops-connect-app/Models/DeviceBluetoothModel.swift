//
//  DeviceBluetoothModel.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 06/07/2023.
//

import Foundation
import UIKit

struct DeviceBluetoothModel: Encodable {
    let deviceId: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let deviceName: String = UIDevice.current.name
}
