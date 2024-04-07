//
//  RecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 07/04/24.
//

import Foundation

protocol RecipesViewModelProtocol: AnyObject {
    
}

final class RecipesViewModel: RecipesViewModelProtocol {
    
    let userInfoStorage: UserInfoStorageProtocol
    let recipesService: RecipesServiceProtocol
    
    init(userInfoStorage: UserInfoStorageProtocol, recipesService: RecipesServiceProtocol) {
        self.userInfoStorage = userInfoStorage
        self.recipesService = recipesService
    }
    
}
