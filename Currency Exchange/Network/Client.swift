//
//  Client.swift
//  Currency Exchange
//
//  Created by Devanshu on 18/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation

class USDClient {
    
    func USDtoEUR(from: String, to: String, completionHandler: @escaping (ExchangeRate?, Error?) -> Void) {
        
        let urlString = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(from)&to_currency=\(to)&apikey="
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
            if error != nil {
                completionHandler(nil, error!)
            } else {
                do {
                    let result = try JSONDecoder().decode(Root.self, from: data!)
                    completionHandler(result.exchangeRate, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        })
        task.resume()
    }
    
    func USDtoGBP(from: String, to: String, completionHandler: @escaping (ExchangeRate?, Error?) -> Void) {
        
        let urlString = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(from)&to_currency=\(to)&apikey="
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
            if error != nil {
                completionHandler(nil, error!)
            } else {
                do {
                    let result = try JSONDecoder().decode(Root.self, from: data!)
                    completionHandler(result.exchangeRate, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        })
        task.resume()
    }
    
    func USDtoINR(from: String, to: String, completionHandler: @escaping (ExchangeRate?, Error?) -> Void) {
        
        let urlString = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(from)&to_currency=\(to)&apikey="
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
            if error != nil {
                completionHandler(nil, error!)
            } else {
                do {
                    let result = try JSONDecoder().decode(Root.self, from: data!)
                    completionHandler(result.exchangeRate, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        })
        task.resume()
}
}
