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
    
    func saveRecipe(_ recipe: Recipe)
}

final class RecipeCellViewModel: RecipeCellViewModelProtocol {
    
    private let recipe: Recipe
    
    var recipeLabel: String
    var mealType: String
    var cuisineType: String
    var image: String
    var isFavourite: CurrentValueSubject<Bool, Never>
    
    private let coreDataManager: CoreDataManagerProtocol

    init(recipe: Recipe, coreDataManager: CoreDataManagerProtocol) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
        
        recipeLabel = recipe.label
        mealType = recipe.mealType.joined(separator: ",")
        cuisineType = recipe.cuisineType.joined(separator: ",")
        image = recipe.image
        isFavourite = CurrentValueSubject(recipe.isFavourite)
    }
    
    func saveRecipe(_ recipe: Recipe) {
        guard let context = coreDataManager.managedObjectContext else {
            return
        }
        let recipeEntity = RecipeEntity(context: context)
        
        recipeEntity.label = recipe.label
        recipeEntity.image = recipe.image
        recipeEntity.calories = recipe.calories
        recipeEntity.cuisineType = recipe.cuisineType.joined(separator: ", ")
        recipeEntity.mealType = recipe.mealType.joined(separator: ", ")
        recipeEntity.isFavourite = true
        
        coreDataManager.saveObject(object: recipeEntity)
    }
}
