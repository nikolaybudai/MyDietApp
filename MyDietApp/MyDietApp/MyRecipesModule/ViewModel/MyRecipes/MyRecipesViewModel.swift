//
//  MyRecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 19/04/24.
//

import UIKit

//MARK: - Protocol
protocol MyRecipesViewModelProtocol: AnyObject {
    var mealTypeOptions: [String] { get }
    var mealTypeChoiceHandler: (UIAction) -> Void { get }
    var mealChosen: String { get set }
    var cuisineTypeOptions: [String] { get }
    var cuisineTypeChoiceHandler: (UIAction) -> Void { get }
    var cuisineChosen: String { get set }
}

//MARK: - Implementation
final class MyRecipesViewModel: MyRecipesViewModelProtocol {
    
    //MARK: Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    var mealTypeOptions: [String] = {
        var meals: [String] = []
        MealType.allCases.forEach { meal in
            meals.append(meal.rawValue)
        }
        return meals
    }()
    
    lazy var mealTypeChoiceHandler: (UIAction) -> Void = { [weak self] action in
        self?.mealChosen = action.title
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
    
}
