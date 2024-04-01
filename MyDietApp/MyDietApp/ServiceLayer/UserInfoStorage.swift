//
//  UserInfoStorage.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 31/03/24.
//

import UIKit

protocol UserInfoStorageProtocol: AnyObject {
    var hasFilledData: Bool { get set }
    func saveNameAndDiet(_ name: String, _ diet: String)
    func saveImage(_ image: UIImage)
    func loadImage() -> UIImage?
}

final class UserInfoStorage: UserInfoStorageProtocol {
    
    var hasFilledData: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hasFilledData")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "hasFilledData")
        }
    }
    
    func saveNameAndDiet(_ name: String, _ diet: String) {
        UserDefaults.standard.setValue(name, forKey: "userName")
        UserDefaults.standard.setValue(diet, forKey: "userDiet")
    }
    
    func saveImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try? PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "userImage")
    }
    
    func loadImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "userImage") else { return nil }
        let decoded = try? PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded ?? Data())
        return image
    }
    
    
}
