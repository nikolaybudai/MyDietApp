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

    var queryItems: [URLQueryItem]? = {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "app_id",
                                  value: "5939db06"))
        items.append(URLQueryItem(name: "app_key",
                                  value: "f2ae0e71dd9093f8d9d654795212e0e7"))
        items.append(URLQueryItem(name: "type",
                                  value: "public"))
        return items
    }()
}

extension RecipesEndpoint {
    func nextURL(_ newURL: URL) -> Self {
        var endpoint = self
        endpoint.scheme = newURL.scheme ?? ""
        endpoint.host = newURL.host ?? ""
        endpoint.path = newURL.path
        
        if let contValue = URLComponents(url: newURL, 
                                         resolvingAgainstBaseURL: false)?.queryItems?.first(where: {
            $0.name == "_cont"
        })?.value {
            endpoint.queryItems?.removeAll(where: { $0.name == "_cont" })
            endpoint.queryItems?.append(URLQueryItem(name: "_cont", value: contValue))
        }
        
        return endpoint
    }
}
