//
//  Model.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

// MARK: - Response
struct RecipesResponse: Decodable {
    let from, to, count: Int
    let links: ResponseLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Next
struct Next: Decodable {
    let href: String
}

// MARK: - Recipe
struct Recipe: Decodable, Hashable {
    let image: String
    let label: String
    let calories: Double
    let cuisineType: [String]
    let mealType: [String]
}

// MARK: - ResultsLinks
struct ResponseLinks: Decodable {
    let next: Next
}
