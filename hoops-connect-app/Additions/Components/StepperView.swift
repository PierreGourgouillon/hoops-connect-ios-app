//
//  StepperView.swift
//  hoops-connect-app
//
//  Created by Pierre Gourgouillon on 01/07/2023.
//

import SwiftUI

struct StepperView: View {
    private var numberOfStep: Int
    @Binding private var currentIndex: Int

    init(numberOfStep: Int, currentIndex: Binding<Int>) {
        self.numberOfStep = numberOfStep
        _currentIndex = currentIndex
    }

    var body: some View {
        HStack {
            ForEach((0...numberOfStep - 1), id: \.self) { step in
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 8)
                    .fullWidth()
                    .foregroundColor(step <= currentIndex ? .green : .black)
            }
        }
        .fullWidth()
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(numberOfStep: 3, currentIndex: .constant(0))
    }
}
