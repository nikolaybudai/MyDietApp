//
//  CoreDataTests.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 06/05/24.
//

import XCTest
import CoreData
@testable import MyDietApp

final class CoreDataTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerProtocol!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()
    }

    override func tearDown() {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        if let results = try? coreDataManager.managedObjectContext?.fetch(fetchRequest) {
            for object in results {
                coreDataManager.managedObjectContext?.delete(object)
            }
            try? coreDataManager.managedObjectContext?.save()
        }
        
        coreDataManager = nil
        super.tearDown()
    }

    func testSaveObject() throws {
        guard let context = coreDataManager.managedObjectContext else {
            XCTFail("Cannot get manajedObjectContext")
            return
        }
        let recipe = RecipeEntity(context: context)
        recipe.calories = 200.0
        recipe.isFavourite = true
        recipe.label = "TestRecipe"
        
        coreDataManager.saveObject(object: recipe)
        
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label == %@", "TestRecipe")
        
        if let savedRecipes = try? context.fetch(fetchRequest) {
            XCTAssertEqual(savedRecipes.count, 1, "Unexpected number of recipes saved")
            
            let savedRecipe = savedRecipes.first!
            XCTAssertEqual(savedRecipe.calories, 200.0)
            XCTAssertTrue(savedRecipe.isFavourite)
            XCTAssertEqual(savedRecipe.label, "TestRecipe")
        } else {
            XCTFail("Failed to fetch saved recipe")
        }
    }
    
    func testDeleteObject() {
        guard let context = coreDataManager.managedObjectContext else {
            XCTFail("Cannot get manajedObjectContext")
            return
        }
        let recipe = RecipeEntity(context: context)
        recipe.calories = 100.0
        recipe.isFavourite = false
        recipe.label = "NewRecipe"
        
        coreDataManager.saveObject(object: recipe)
        
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label == %@", "NewRecipe")
        
        guard let savedRecipes = try? context.fetch(fetchRequest),
                let _ = savedRecipes.first else {
            XCTFail("Failed to fetch saved recipe")
            return
        }
        
        coreDataManager.deleteObject(object: recipe)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           let remainingRecipes = try? context.fetch(fetchRequest)
           XCTAssertEqual(remainingRecipes?.count, 0)
       }
    }
    
    func testFetchRecipes() {
        guard let context = coreDataManager.managedObjectContext else {
            XCTFail("Cannot get manajedObjectContext")
            return
        }
        
        let recipe1 = RecipeEntity(context: context)
        recipe1.label = "Recipe 1"
        recipe1.calories = 200
        recipe1.isFavourite = true
        
        let recipe2 = RecipeEntity(context: context)
        recipe2.label = "Recipe 2"
        recipe2.calories = 300
        recipe2.isFavourite = false
        
        coreDataManager.saveObject(object: recipe1)
        coreDataManager.saveObject(object: recipe2)
        
        let favoritePredicate = NSPredicate(format: "isFavourite == true", true)
        let favoriteRecipesResult = coreDataManager.fetchRecipes(with: favoritePredicate)
        
        switch favoriteRecipesResult {
        case .success(let favoriteRecipes):
            XCTAssertEqual(favoriteRecipes.count, 1)
            XCTAssertEqual(favoriteRecipes[0].label, "Recipe 1")
        case .failure(let error):
            XCTFail("Failed to fetch favorite recipes")
        }
    }

}
