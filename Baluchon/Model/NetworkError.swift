//
//  NetworkError.swift
//  Baluchon
//
//  Created by Déborah Suon on 09/12/2021.
//

import Foundation

enum NetworkError: Error {
    case  noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData: return "The service is momentarily unavailable"
        case .invalidResponse: return "The service is momentarily unavailable"
        case .undecodableData: return "The service is momentarily unavailable"
        }
    }
}
