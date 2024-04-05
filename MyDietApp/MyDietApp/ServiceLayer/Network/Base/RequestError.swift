//
//  RequestError.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

enum RequestError: Error {
    case decoding
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decoding: return "Decoding error"
        case .invalidURL: return "Invalid url"
        case .noResponse: return "No response recieved"
        case .unauthorized: return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
