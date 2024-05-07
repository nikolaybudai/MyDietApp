//
//  UserInfoStorageTests.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 07/05/24.
//

import XCTest
@testable import MyDietApp

final class UserInfoStorageTests: XCTestCase {
    
    var userInfoStorage: UserInfoStorageProtocol!

    override func setUp() {
        super.setUp()
        userInfoStorage = UserInfoStorage()
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

    override func tearDown() {
        userInfoStorage = nil
        super.tearDown()
    }

    func testSaveNameAndDiet() {
        userInfoStorage.saveNameAndDiet("Alex", "Low-fat")
        XCTAssertEqual(userInfoStorage.diet, "Low-fat")
    }
    
    func testHasFilledData() {
        userInfoStorage.hasFilledData = true
        XCTAssertTrue(userInfoStorage.hasFilledData)
    }
    
    func testSaveAndLoadImage() {
        guard let image = UIImage(systemName: "person.fill") else {
            XCTFail("Failed to load test image")
            return
        }
        userInfoStorage.saveImage(image)
        let loadedImage = userInfoStorage.loadImage()
        XCTAssertNotNil(loadedImage, "Loaded image should not be nil")
    }
    
    func testLoadImageFailure() {
        let loadedImage = userInfoStorage.loadImage()
        XCTAssertNil(loadedImage)
    }
}
