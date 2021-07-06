//
//  SimulateLog.swift
//  BuyAvocado
//
//  Created by Lam Nguyen Huu (VN) on 29/06/2021.
//

import Foundation

class SimulateTimer {
    class func currentTime() -> Float {
        let second = Float.random(in: 2...5)
        Thread.sleep(forTimeInterval: TimeInterval(second))
        return second
    }
}
