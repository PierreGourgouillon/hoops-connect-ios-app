//
//  HomeView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 29/06/2023.
//

import SwiftUI
import CoreBluetooth
import UIKit

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel = .init()
    @ObservedObject private var bluetoothManager: BluetoothManager = .init()

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Hello world")
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            bluetoothManager.initialize()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                let data = BodyBluetoothModel(type: "score", data: "")
                let jsonEncoder = JSONEncoder()
                if let jsonData = try? jsonEncoder.encode(data),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    bluetoothManager.writeValue(data: jsonString)
                }
            })
        }
    }
}

struct MyData: Codable {
    let key1: String
    let key2: Int
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
