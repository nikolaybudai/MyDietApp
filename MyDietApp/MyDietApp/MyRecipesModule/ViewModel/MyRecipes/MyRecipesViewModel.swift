//
//  MyRecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 19/04/24.
//

import UIKit
import Combine

enum MyRecipesSection {
    case recipe
}

//MARK: - Protocol
protocol MyRecipesViewModelProtocol: AnyObject {
    var hasFailure: CurrentValueSubject<Bool, Never> { get }
    var mealTypeOptions: [String] { get }
    var mealTypeChoiceHandler: (UIAction) -> Void { get }
    var mealChosen: String { get set }
    var cuisineTypeOptions: [String] { get }
    var cuisineTypeChoiceHandler: (UIAction) -> Void { get }
    var cuisineChosen: String { get set }
    var myRecipesDiffableDataSource: UITableViewDiffableDataSource<MyRecipesSection, Recipe>? { get set }
}

//MARK: - Implementation
final class MyRecipesViewModel: MyRecipesViewModelProtocol {
    
    //MARK: Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    var hasFailure = CurrentValueSubject<Bool, Never>(false)
    
    var myRecipesDiffableDataSource: UITableViewDiffableDataSource<MyRecipesSection, Recipe>?
    
    var mealTypeOptions: [String] = {
        var meals: [String] = []
        MealType.allCases.forEach { meal in
            meals.append(meal.rawValue)
        }
        return meals
    }()
    
    lazy var mealTypeChoiceHandler: (UIAction) -> Void = { [weak self] action in
        let meal = action.title
        self?.mealChosen = meal
        self?.fetchRecipesWithMealType(meal)
    }
    var mealChosen: String = ""
    
    var cuisineTypeOptions: [String] = {
        var cuisines: [String] = []
        CuisineType.allCases.forEach { cuisine in
            cuisines.append(cuisine.rawValue)
        }
        return cuisines
    }()
    
    lazy var cuisineTypeChoiceHandler: (UIAction) -> Void = { [weak self] action in
        self?.cuisineChosen = action.title
    }
    var cuisineChosen: String = ""
    
    //MARK: Init
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    //MARK: Methods
    private func fetchRecipesWithMealType(_ mealType: String) {
        let predicate = NSPredicate(format: "mealType CONTAINS %@", mealType)
        let result = coreDataManager.fetchRecipes(with: predicate)
        switch result {
        case .success(_):
            // update data source with recipes
            break
        case .failure(_):
            hasFailure.send(true)
        }
    }
    
    private func fetchRecipesWithCuisine(_ cuisine: String) {
        let predicate = NSPredicate(format: "cuisineType CONTAINS %@", cuisine)
        let result = coreDataManager.fetchRecipes(with: predicate)
        switch result {
        case .success(_):
            // update data source with recipes
            break
        case .failure(_):
            hasFailure.send(true)
        }
    }
    
}
