//
//  RecipesViewModelTests.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 10/05/24.
//

import XCTest
@testable import MyDietApp

class RecipesViewModelTests: XCTestCase {
    
    var viewModel: RecipesViewModel!
    var mockCoreDataManager: CoreDataManagerMock!
    var mockRecipesService: RecipesServiceMock!
    var mockUserInfoStorage: UserInfoStorageMock!
    
    override func setUp() {
        super.setUp()
        mockRecipesService = RecipesServiceMock()
        mockUserInfoStorage = UserInfoStorageMock()
        mockCoreDataManager = CoreDataManagerMock()
        viewModel = RecipesViewModel(userInfoStorage: mockUserInfoStorage,
                                     recipesService: mockRecipesService,
                                     coreDataManager: mockCoreDataManager)
    }
    
    override func tearDown() {
        mockCoreDataManager = nil
        mockUserInfoStorage = nil
        mockRecipesService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRecipesSuccess() {
        let expectation = XCTestExpectation()
        let expectedNumber = 5

        viewModel.fetchRecipes(with: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.mockRecipesService.numberOfItems, expectedNumber)
            XCTAssertEqual(self.viewModel.currentCuisineTypeIndex, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchRecipesFailure() {
        let expectation = XCTestExpectation()
        let expectedNumber = 0
        mockRecipesService.shouldReturnError = true
        
        viewModel.fetchRecipes(with: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.hasFailure.value)
            XCTAssertTrue(self.viewModel.isLoading.value == false)
            XCTAssertEqual(self.mockRecipesService.numberOfItems, expectedNumber)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchMoreRecipesSuccess() {
        let expectation = XCTestExpectation()
        let expectedNumber = 10
        
        let nextEndpoint = RecipesEndpoint()
        viewModel.currentNextEndpoint = nextEndpoint
        
        viewModel.fetchMoreRecipes(with: nextEndpoint)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.isLoadingMoreRecipes == false)
            XCTAssertFalse(self.viewModel.hasFailure.value)
            XCTAssertEqual(self.mockRecipesService.fetchedMoreNumber, expectedNumber)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchMoreRecipesFailure() {
        let expectation = XCTestExpectation()
        let expectedNumber = 0
        mockRecipesService.shouldReturnError = true

        let nextEndpoint = RecipesEndpoint()
        
        viewModel.fetchMoreRecipes(with: nextEndpoint)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.isLoadingMoreRecipes == false)
            XCTAssertFalse(self.viewModel.isLoadingMoreRecipes)
            XCTAssertFalse(self.viewModel.isLoading.value)
            XCTAssertEqual(self.mockRecipesService.fetchedMoreNumber, expectedNumber)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
}
