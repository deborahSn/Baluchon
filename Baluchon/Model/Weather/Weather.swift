//
//  Weather.swift
//  Baluchon
//
//  Created by Déborah Suon on 05/11/2021.
//

import Foundation
struct WeatherInfo: Decodable {
    let list: [List]
}

struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp : Double

}

struct Weather: Decodable {
    let description : String
}
