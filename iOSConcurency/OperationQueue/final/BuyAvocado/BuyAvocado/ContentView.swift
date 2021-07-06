//
//  ContentView.swift
//  BuyAvocado
//
//  Created by Lam Nguyen Huu (VN) on 29/06/2021.
//

import SwiftUI
import Combine

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
    
    @State private var operationQueue = OperationQueue()
    
    @State var cancellable: Cancellable?
    
    
    var body: some View {
        VStack {
            Text("Avocado")
                .padding()
                .font(.title)
            Text(cusIndex < customers.count ? customers[cusIndex] : "No customer")
            Button {
                let customerIndex = cusIndex
                let customerName = cusIndex < customers.count ? customers[cusIndex] : "No customer"
                
                
                let opertionBloc = BlockOperation {
                    let currentTime = SimulateTimer.currentTime()
                    DispatchQueue.main.async {
                        if customerIndex < customers.count {
                            logContent.append("\(customerName) buy at time \(currentTime)\n")
                        }
                    }
                }
                
                opertionBloc.completionBlock = {
                    print("finished buy avocado \(customerName)")
                }
                
                let paymentOperation = BlockOperation {
                    let currentTime = SimulateTimer.currentTime()
                    DispatchQueue.main.async {
                        if customerIndex < customers.count {
                            logContent.append("\(customerName) pay money \(currentTime)\n")
                           
                        }
                    }
                }
                
                cancellable = paymentOperation.publisher(for: \.isCancelled).sink(receiveValue: { value in
                    print("cancel value for \(customerName)")
                })
                
                
                paymentOperation.completionBlock = {
                    print("payment value for \(customerName)")
                }
                
                paymentOperation.addDependency(opertionBloc)
                
                
                operationQueue.addOperation(paymentOperation)
                operationQueue.addOperation(opertionBloc)
                
                if cusIndex < customers.count {
                    cusIndex += 1
                }
                
            } label: {
                Text("By Avocado")
            }
            Spacer()
//            List
//            {
            Text(logContent)
//            }
            Spacer()
            Slider(value: $value, in: 0.3...1)
            
            Button {
                print("Cancel all operations")
                operationQueue.cancelAllOperations()
            } label: {
                Text("Cancel operation")
            }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
