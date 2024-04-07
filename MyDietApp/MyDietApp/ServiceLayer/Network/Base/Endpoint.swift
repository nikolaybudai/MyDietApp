//
//  Endpoint.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

//extension Endpoint {
//    var scheme: String {
//        return "https"
//    }
//    
//    var host: String {
//        return
//    }
//
//    var path: String {
//        return "api.edamam.com/api/recipes/v2"
//    }
//    
//    var queryItems: [URLQueryItem] {
//        return [URLQueryItem(name: "app_id", value: "5939db06"),
//                URLQueryItem(name: "app_key", value: "f2ae0e71dd9093f8d9d654795212e0e7"),
//                URLQueryItem(name: "type", value: "public")]
//    }
//}
