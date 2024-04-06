//
//  Model.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
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
struct Recipe: Decodable {
    let image: String
    let calories: Double
    let cuisineType: [CuisineType]
    let mealType: [MealType]
}

// MARK: - ResultsLinks
struct ResponseLinks: Decodable {
    let next: Next
}
