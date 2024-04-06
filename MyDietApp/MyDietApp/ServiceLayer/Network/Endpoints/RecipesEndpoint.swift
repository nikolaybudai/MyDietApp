//
//  RecipesEndpoint.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

struct RecipesEndpoint: Endpoint {
    var path: String
    var method: RequestMethod = {
        return .get
    }()
    var header: [String : String]?
    var body: [String : String]?
    var queryItems: [URLQueryItem]?
}
