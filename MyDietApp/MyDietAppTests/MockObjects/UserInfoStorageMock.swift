//
//  UserInfoStorageMock.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 07/05/24.
//

@testable import protocol MyDietApp.UserInfoStorageProtocol
import UIKit

class UserInfoStorageMock: UserInfoStorageProtocol {
    
    var hasFilledData: Bool = false
    
    var saveImageCalled = false
    var savedImage: UIImage?
    
    var saveNameAndDietCalled = false
    var savedName: String?
    var diet: String = "aaa"

    func saveNameAndDiet(_ name: String, _ diet: String) {
        saveNameAndDietCalled = true
        savedName = name
        self.diet = diet
    }

    func saveImage(_ image: UIImage) {
        saveImageCalled = true
        savedImage = image
    }

    func loadImage() -> UIImage? {
        return savedImage
    }
    
    func getNameAndDiet() -> (String?, String?) {
        return (savedName, diet)
    }
}
