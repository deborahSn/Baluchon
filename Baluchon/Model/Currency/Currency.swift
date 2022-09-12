//
//  Currency.swift
//  Baluchon
//
//  Created by Déborah Suon on 28/10/2021.
//

import Foundation

struct Currency: Decodable {
    
    var rates: [String: Double]
    
    // convert from euro to dollars
    func convertStartValue(value: Double, rate: Double) -> Double {
        return value * rate
    }
    
    func convert(value: Double, from: String, to: String) -> Double {
        guard let rate = rates[to] else { return 0.00 }
        let convertValue = convertStartValue(value: value, rate: rate)
        return convertValue
    }
}


