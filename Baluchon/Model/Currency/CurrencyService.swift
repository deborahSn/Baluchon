//
//  Currency.swifvt.swift
//  Baluchon
//
//  Created by Déborah Suon on 18/10/2021.
//

import Foundation

 

class CurrencyService {
    
    let currencySession: URLSession
    var task: URLSessionDataTask?
    let currencyURL: String = "http://data.fixer.io/api/latest"

    
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    func fetchCurrency(callback: @escaping (Result<Currency, NetworkError>) -> Void) {
        guard let baseURL: URL = .init(string: currencyURL) else { return }
        let url: URL = encode(with: baseURL, and: [("access_key", "1a08dd717f236b098b6c357bfcc99e8f")])
        currencySession.dataTask(with: url, callback: callback)
    }
}

extension CurrencyService: URLEncodable {}




     

