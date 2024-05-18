//
//  MyRecipesCellViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/04/24.
//

import Foundation
import Combine

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
}
