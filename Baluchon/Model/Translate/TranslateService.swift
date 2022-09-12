//
//  TranslateService.swift
//  Baluchon
//
//  Created by Déborah Suon on 15/11/2021.
//

import Foundation


enum Language {
    case fr
    case en
}

class TranslateService {
    
    var fromLanguage: String = "fr"
    var toLanguage: String = "en"
    var translateSession: URLSession
    var task: URLSessionDataTask?
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }

    /// send request to the Google API and return response
    func translate(language: Language, text: String, callback: @escaping (Result <Translate, NetworkError>) -> Void) {
        guard let request = fetchTranslate(text: text, language: language) else { return }
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseJSON))
            return
        }
        task?.resume()
    }
    
    /// create my request
    private func fetchTranslate(text: String, language: Language) -> URLRequest? {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return nil }
        var translateRequest = URLRequest(url: url)
        translateRequest.httpMethod = "POST"
        let body = "q=\(text)" + "&\(fromLanguage)" + "&target=\(toLanguage)" + "&key=AIzaSyBLZOUDs9PHZ_g5Y9fgYEo_y9_RqFO-Bjs&format=text"
        translateRequest.httpBody = body.data(using: .utf8)
        return translateRequest
    }
}

// https://translation.googleapis.com/language/translate/v2?q=text&fr&target=en&key=AIzaSyBLZOUDs9PHZ_g5Y9fgYEo_y9_RqFO-Bjs&format=text
