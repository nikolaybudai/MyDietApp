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
    var image: String
    var label: String
    var calories: Double
    var cuisineType: [String]
    var mealType: [String]
    var isFavourite: Bool
    
    enum CodingKeys: String, CodingKey {
        case image, label, calories, cuisineType, mealType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(String.self, forKey: .image)
        self.label = try container.decode(String.self, forKey: .label)
        self.calories = try container.decode(Double.self, forKey: .calories)
        self.cuisineType = try container.decode([String].self, forKey: .cuisineType)
        self.mealType = try container.decode([String].self, forKey: .mealType)
        self.isFavourite = false 
    }
    
    init(from recipeEntity: RecipeEntity) {
        self.image = recipeEntity.image ?? ""
        self.label = recipeEntity.label ?? ""
        self.calories = recipeEntity.calories
        self.cuisineType = recipeEntity.cuisineType?.components(separatedBy: ",") ?? []
        self.mealType = recipeEntity.mealType?.components(separatedBy: ",") ?? []
        self.isFavourite = true
    }
}

// MARK: - ResultsLinks
struct ResponseLinks: Decodable {
    let next: Next
}
