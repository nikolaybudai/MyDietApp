//
//  RecipesEndpoint.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

struct RecipesEndpoint: Endpoint {
    var scheme: String = "https"
    var host: String = "api.edamam.com"
    var path: String = "/api/recipes/v2"
    var method: RequestMethod = {
        return .get
    }()
    var header: [String : String]?
    var body: [String : String]?
    var queryItems: [URLQueryItem]? = [URLQueryItem(name: "app_id", value: "5939db06"),
                                       URLQueryItem(name: "app_key", value: "f2ae0e71dd9093f8d9d654795212e0e7"),
                                       URLQueryItem(name: "type", value: "public")]
}

extension RecipesEndpoint {
    func nextURL(_ newURL: URL) -> Self {
        var endpoint = self
        endpoint.scheme = newURL.scheme ?? ""
        endpoint.host = newURL.host ?? ""
        endpoint.path = newURL.path
        return endpoint
    }
}
