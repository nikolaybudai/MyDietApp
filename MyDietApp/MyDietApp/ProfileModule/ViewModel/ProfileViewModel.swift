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
    var dietChosen: String { get set }
    var name: String { get set }
    
    func saveUserData(_ image: UIImage, _ name: String)
    func loadUserInfo() -> (UIImage?, String?, String?)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    let userInfoStorage: UserInfoStorageProtocol
    
    var dietOptions: [String] = {
        var diets: [String] = []
        DietOptions.allCases.forEach { diet in
            diets.append(diet.rawValue)
        }
        return diets
    }()
    
    lazy var dietChoiceHandler: (UIAction) -> Void = { [weak self] action in
        self?.dietChosen = action.title
    }
    var dietChosen: String = ""
    var name: String = ""
    
    init(userInfoStorage: UserInfoStorageProtocol) {
        self.userInfoStorage = userInfoStorage
    }
    
    func saveUserData(_ image: UIImage, _ name: String) {
        print(name, image, dietChosen)
        userInfoStorage.saveImage(image)
        userInfoStorage.saveNameAndDiet(name, dietChosen)
        userInfoStorage.hasFilledData = true
        self.name = name
    }
    
    func loadUserInfo() -> (UIImage?, String?, String?) {
        let image = userInfoStorage.loadImage()
        let name = UserDefaults.standard.value(forKey: "userName") as? String
        let diet = UserDefaults.standard.value(forKey: "userDiet") as? String
        return (image, name, diet)
    }
}
