//
//  RecipeCellViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 24/04/24.
//

import Foundation
import Combine
import CoreData

//MARK: - Protocol
protocol RecipeCellViewModelProtocol {
    var hasFailure: CurrentValueSubject<Bool, Never> { get }
    var recipeLabel: String { get }
    var mealType: String { get }
    var cuisineType: String { get }
    var image: String { get }
    var isFavourite: CurrentValueSubject<Bool, Never> { get set }
    
    func handleIsFavouriteButton()
}

//MARK: - Implementation
final class RecipeCellViewModel: RecipeCellViewModelProtocol {
    
    //MARK: Properties
    private var recipe: Recipe
    
    var hasFailure = CurrentValueSubject<Bool, Never>(false)
    var recipeLabel: String
    var mealType: String
    var cuisineType: String
    var image: String
    var isFavourite = CurrentValueSubject<Bool, Never>(false)
    
    private let coreDataManager: CoreDataManagerProtocol

    //MARK: Init
    init(recipe: Recipe, coreDataManager: CoreDataManagerProtocol) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
        
        recipeLabel = recipe.label
        mealType = recipe.mealType.joined(separator: ",")
        cuisineType = recipe.cuisineType.joined(separator: ",")
        image = recipe.image
    }
    
    //MARK: Methods
    func handleIsFavouriteButton() {
        recipe.isFavourite.toggle()
        isFavourite.value = recipe.isFavourite
        
        if recipe.isFavourite {
            saveRecipe(recipe)
        } else {
            deleteRecipe(recipe)
        }
    }
    
    private func saveRecipe(_ recipe: Recipe) {
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
    
    private func deleteRecipe(_ recipe: Recipe) {
        guard let context = coreDataManager.managedObjectContext else {
            return
        }
        
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label == %@", recipe.label)
        
        do {
            let fetchedRecipes = try context.fetch(fetchRequest) as [RecipeEntity]
            for fetchedRecipe in fetchedRecipes {
                coreDataManager.deleteObject(object: fetchedRecipe)
            }
        } catch {
            hasFailure.send(true)
        }
    }
}
