//
//  RecipesEndpoint.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

enum MoviesEndpoint {
    case recipies
}

extension MoviesEndpoint: Endpoint {
    
    var path: String {
        return ""
    }
        
    var method: RequestMethod {
        switch self {
        case .recipies:
            return .get
        }
    }
    
    var header: [String : String]? {
        // Access Token to use in Bearer header
        let appID = "5939db06"
        let appKey = "f2ae0e71dd9093f8d9d654795212e0e7"
        switch self {
        case .recipies:
            return [
                "app_id": "5939db06",
                "app_key": "f2ae0e71dd9093f8d9d654795212e0e7"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .recipies:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return []
    }
}
