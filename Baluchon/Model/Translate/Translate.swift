//
//  Translate.swift
//  Baluchon
//
//  Created by Déborah Suon on 15/11/2021.
//

import Foundation

struct Translate: Decodable {
    var data: TranslateData
}

struct TranslateData: Decodable {
    var translations: [TranslateText]
}

struct TranslateText: Decodable {
    var translatedText: String
}
