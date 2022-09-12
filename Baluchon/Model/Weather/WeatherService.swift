//
//  WeatherService.swift
//  Baluchon
//
//  Created by Déborah Suon on 05/11/2021.
//

import Foundation


class WeatherService {
    
    let weatherSession: URLSession
    var task: URLSessionDataTask?
    let weatherURL: String = "http://api.openweathermap.org/data/2.5/group"

    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    func fetchWeather(callback: @escaping (Result<WeatherInfo, NetworkError>) -> Void) {
        guard let baseURL: URL = .init(string: weatherURL) else { return }
        let url: URL = encode(with: baseURL, and: [("id","5128638,2968815"),("units","metric"),("APPID","106f0db32999088d061a4e175f721a8e")])
        weatherSession.dataTask(with: url, callback: callback)
    }
}

extension WeatherService: URLEncodable {}

