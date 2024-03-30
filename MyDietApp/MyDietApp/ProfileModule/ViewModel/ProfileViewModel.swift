//
//  ProfileViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 30/03/24.
//

import UIKit

protocol ProfileViewModelProtocol: AnyObject {
    var dietOptions: [String] { get }
    var dietChoiceHandler:  (UIAction) -> Void { get }
    
    func saveUserData()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var dietOptions: [String] = {
        var diets: [String] = []
        DietOptions.allCases.forEach { diet in
            diets.append(diet.rawValue)
        }
        return diets
    }()
    
    var dietChoiceHandler: (UIAction) -> Void = { action in
        print(action.title)
    }
    
    func saveUserData() {
        print("Save user info")
    }
}
