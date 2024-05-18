//
//  ProfileViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 30/03/24.
//

import UIKit

//MARK: - Protocol
protocol ProfileViewModelProtocol: AnyObject {
    var dietOptions: [String] { get }
    var dietChoiceHandler:  (UIAction) -> Void { get }
    var dietChosen: String { get set }
    var name: String { get set }
    
    func saveUserData(_ image: UIImage, _ name: String)
    func loadUserInfo() -> (UIImage?, String?, String?)
}

//MARK: - Implementation
final class ProfileViewModel: ProfileViewModelProtocol {
    
    //MARK: Properties
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
    
    //MARK: Init
    init(userInfoStorage: UserInfoStorageProtocol) {
        self.userInfoStorage = userInfoStorage
    }
    
    //MARK: Methods
    func saveUserData(_ image: UIImage, _ name: String) {
        userInfoStorage.saveImage(image)
        userInfoStorage.saveNameAndDiet(name, dietChosen)
        userInfoStorage.hasFilledData = true
        self.name = name
    }
    
    func loadUserInfo() -> (UIImage?, String?, String?) {
        let image = userInfoStorage.loadImage()
        let (name, diet) = userInfoStorage.getNameAndDiet()
        return (image, name, diet)
    }
}
