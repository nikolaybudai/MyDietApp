//
//  RecipeDetailViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 18/04/24.
//

import Foundation

protocol RecipeDetailViewModelProtocol: AnyObject {
    var recipeLabel: String { get }
    var image: String { get }
    var calories: Double { get }
    var mealType: [String] { get }
    var cuisineType: [String] { get }
}

final class RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    
    var recipeLabel: String
    var image: String
    var calories: Double
    var mealType: [String]
    var cuisineType: [String]
    
    init(recipe: Recipe) {
        self.recipeLabel = recipe.label
        self.image = recipe.image
        self.calories = recipe.calories
        self.mealType = recipe.mealType
        self.cuisineType = recipe.cuisineType
    }
}
