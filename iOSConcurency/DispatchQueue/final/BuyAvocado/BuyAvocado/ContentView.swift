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
    
    @State private var queue = DispatchQueue(label: "com.hula.serialQueue")
    
    var body: some View {
        VStack {
            Text("Avocado")
                .padding()
                .font(.title)
            Text(cusIndex < customers.count ? customers[cusIndex] : "No customer")
            Button {
                
                DispatchQueue.global().async {
                    let currentTime = SimulateTimer.currentTime()
                    DispatchQueue.main.async {
                        if cusIndex < customers.count {
                            logContent.append("\(customers[cusIndex]) by at time \(currentTime)\n")
                            cusIndex += 1
                        }
                    }
                }
  
//                queue.async {
//                    let currentTime = SimulateTimer.currentTime()
//                    DispatchQueue.main.async {
//                        if cusIndex < customers.count {
//                        logContent.append("\(customers[cusIndex]) by at time \(currentTime)\n")
//                            cusIndex += 1
//                        }
//                    }
//                }
                ////Bonus if you work for ios 15 and xcode 13 then can use async and await for this. This make the code structured and clean.
//                if #available(iOS 15.0, *) {
//                    async {
//                        let currentTime = await getTime()
//                        if cusIndex < customers.count {
//                            logContent.append("\(customers[cusIndex]) by at time \(currentTime)\n")
//                            cusIndex += 1
//                        }
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
                
                
            } label: {
                Text("By Avocado")
            }
            Spacer()
            Text(logContent)
            Spacer()
            Slider(value: $value, in: 0.3...1)
            Button {
                cusIndex = 0
                logContent = ""
            } label: {
                Text("Reset to default")
            }

        }
        .padding()
        .opacity(value)
    }
    
    func getTime() async -> Float {
        let currentTime = SimulateTimer.currentTime()
        return currentTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
