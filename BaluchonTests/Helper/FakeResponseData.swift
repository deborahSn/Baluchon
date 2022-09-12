//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Déborah Suon on 09/01/2022.
//

import Foundation

class FakeResponseData {
    static let fixerUrl: URL = URL(string: "http://data.fixer.io/api/latest?access_key=1a08dd717f236b098b6c357bfcc99e8f")!

    static let translateUrl: URL = URL(string: "https://translation.googleapis.com/language/translate/v2?q=text&fr&target=en&key=AIzaSyBLZOUDs9PHZ_g5Y9fgYEo_y9_RqFO-Bjs&format=text")!
    static let weatherUrl: URL = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,2968815&units=metric&APPID=106f0db32999088d061a4e175f721a8e")!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://networkcalc.com/api/binary/1101111")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://networkcalc.com/api/binary/1101111")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var fixerData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static var weatherData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translateData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!

}
