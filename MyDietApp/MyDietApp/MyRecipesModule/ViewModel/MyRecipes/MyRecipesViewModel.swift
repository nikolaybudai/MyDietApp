//
//  MyRecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 19/04/24.
//

import Foundation

//MARK: - Protocol
protocol MyRecipesViewModelProtocol: AnyObject {
    
}

//MARK: - Implementation
final class MyRecipesViewModel: MyRecipesViewModelProtocol {
    
    //MARK: Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    //MARK: Init
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    //MARK: Methods
    
}
