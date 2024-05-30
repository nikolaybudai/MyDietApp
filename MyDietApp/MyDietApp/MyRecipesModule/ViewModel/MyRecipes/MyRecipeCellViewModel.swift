//
//  MyRecipesCellViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/04/24.
//

import Foundation
import Combine
import CoreData

//MARK: - Protocol
protocol MyRecipeCellViewModelProtocol: AnyObject {
    var recipeLabel: String { get }
    var mealType: String { get }
    var cuisineType: String { get }
    var image: String { get }
}

//MARK: - Implementation
final class MyRecipeCellViewModel: MyRecipeCellViewModelProtocol {
    
    var recipeLabel: String
    var mealType: String
    var cuisineType: String
    var image: String
    
    //MARK: Properties
    private let recipe: Recipe
    
    private let coreDataManager: CoreDataManagerProtocol
    
    //MARK: Init
    init(recipe: Recipe,
         coreDataManager: CoreDataManagerProtocol) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
        
        recipeLabel = recipe.label
        mealType = recipe.mealType.joined(separator: ",")
        cuisineType = recipe.cuisineType.joined(separator: ",")
        image = recipe.image
    }
    
    //MARK: Methods
    func deleteRecipe(_ recipe: Recipe) {
        let predicate = NSPredicate(format: "label == %@ AND calories == %f AND image == %@", recipe.label, recipe.calories, recipe.image)
        let fetchResult = coreDataManager.fetchRecipes(with: predicate)

        switch fetchResult {
        case .success(let recipeEntities):
            if let recipeEntity = recipeEntities.first {
                coreDataManager.deleteObject(object: recipeEntity)
            }
        case .failure(let error):
            print("Failed to fetch recipe for deletion: \(error)")
        }
    }
}
