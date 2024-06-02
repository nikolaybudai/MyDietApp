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
    
    func deleteRecipe()
}

protocol MyRecipesCellViewModelDelegate: AnyObject {
    func shouldUpdateDataSource(without recipe: Recipe)
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
    
    weak var delegate: MyRecipesCellViewModelDelegate?
    
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
    func deleteRecipe() {
        let predicate = NSPredicate(format: "label == %@", recipe.label)
        let fetchResult = coreDataManager.fetchRecipes(with: predicate)

        switch fetchResult {
        case .success(let recipeEntities):
            print(recipeEntities)
            if let recipeEntity = recipeEntities.first {
                coreDataManager.deleteObject(object: recipeEntity)
                delegate?.shouldUpdateDataSource(without: recipe)
            }
        case .failure(let error):
            print("Failed to fetch recipe for deletion: \(error)")
        }
    }
}
