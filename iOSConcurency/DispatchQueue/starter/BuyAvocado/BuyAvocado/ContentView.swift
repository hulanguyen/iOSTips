//
//  ContentView.swift
//  BuyAvocado
//
//  Created by Lam Nguyen Huu (VN) on 29/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var value: Double = 1.0
    private let customers = [
    "Hula",
    "Alex",
    "John",
    "Micheal",
    "Lina",
    "Alizabez"
    ]
    
    @State private var cusIndex = 0
    
    @State private var logContent = ""
    var body: some View {
        VStack {
            Text("Avocado")
                .padding()
                .font(.title)
            Text(cusIndex == -1 ? "No customer" : customers[cusIndex])
            Button {
                
                let currentTime = SimulateTimer.currentTime()
                logContent.append("\(customers[cusIndex]) by at time \(currentTime)\n")
                if cusIndex > customers.count {
                    cusIndex = -1
                } else {
                    cusIndex += 1
                }
            } label: {
                Text("By Avocado")
            }
            Spacer()
            Text(logContent)
            Spacer()
            Slider(value: $value, in: 0.3...1)
            Button {
                cusIndex = 0
            } label: {
                Text("Reset to default")
            }

        }
        .padding()
        .opacity(value)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
