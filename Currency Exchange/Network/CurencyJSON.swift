//
//  CurencyJSON.swift
//  Currency Exchange
//
//  Created by Devanshu on 24/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation

struct Root : Decodable {
    
    let exchangeRate : ExchangeRate
    private enum  CodingKeys: String, CodingKey { case exchangeRate = "Realtime Currency Exchange Rate" }
}

struct ExchangeRate : Decodable {
    
    let fromCode, fromName, toCode, toName, rate : String
    let lastRefreshed, timeZone : String
    
    private enum  CodingKeys: String, CodingKey {
        case fromCode = "1. From_Currency Code"
        case fromName = "2. From_Currency Name"
        case toCode = "3. To_Currency Code"
        case toName = "4. To_Currency Name"
        case rate = "5. Exchange Rate"
        case lastRefreshed = "6. Last Refreshed"
        case timeZone = "7. Time Zone"
        
    }
    
    var floatRate : Float {
        return Float(rate) ?? 0.0
    }
}

