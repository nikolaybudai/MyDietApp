//
//  RecipeCellViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 24/04/24.
//

import Foundation
import Combine

protocol RecipeCellViewModelProtocol {
    var recipeLabel: String { get }
    var mealType: String { get }
    var cuisineType: String { get }
    var image: String { get }
    var isFavourite: CurrentValueSubject<Bool, Never> { get set }
}

final class RecipeCellViewModel: RecipeCellViewModelProtocol {
    
    private let recipe: Recipe
    
    var recipeLabel: String
    var mealType: String
    var cuisineType: String
    var image: String
    var isFavourite: CurrentValueSubject<Bool, Never>

    init(recipe: Recipe) {
        self.recipe = recipe
        recipeLabel = recipe.label
        mealType = recipe.mealType.joined(separator: ",")
        cuisineType = recipe.cuisineType.joined(separator: ",")
        image = recipe.image
        isFavourite = CurrentValueSubject(recipe.isFavourite)
    }
}
