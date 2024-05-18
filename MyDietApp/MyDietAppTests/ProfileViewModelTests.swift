//
//  ProfileViewModelTests.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 07/05/24.
//

import XCTest
@testable import MyDietApp

class ProfileViewModelTests: XCTestCase {
    
    var viewModel: ProfileViewModelProtocol!
    var mockUserInfoStorage: UserInfoStorageMock!

    override func setUp() {
        super.setUp()
        mockUserInfoStorage = UserInfoStorageMock()
        viewModel = ProfileViewModel(userInfoStorage: mockUserInfoStorage)
    }

    override func tearDown() {
        viewModel = nil
        mockUserInfoStorage = nil
        super.tearDown()
    }

    func testSaveUserData() {
        let testImage = UIImage(systemName: "person.fill")!
        let testName = "John"

        viewModel.saveUserData(testImage, testName)

        XCTAssertTrue(mockUserInfoStorage.saveImageCalled)
        XCTAssertEqual(mockUserInfoStorage.savedImage, testImage)

        XCTAssertTrue(mockUserInfoStorage.saveNameAndDietCalled)
        XCTAssertEqual(mockUserInfoStorage.savedName, testName)

        XCTAssertTrue(mockUserInfoStorage.hasFilledData)

        XCTAssertEqual(viewModel.name, testName)
    }
    
    func testLoadUserData() {
        let testImage = UIImage(systemName: "person.fill")!
        let testName = "Mike"
        
        viewModel.saveUserData(testImage, testName)
        XCTAssertTrue(mockUserInfoStorage.saveNameAndDietCalled)
        let (loadedImage, loadedName, _) = viewModel.loadUserInfo()
        
        XCTAssertEqual(loadedImage, testImage)
        XCTAssertEqual(loadedName, testName)
    }
    
}
