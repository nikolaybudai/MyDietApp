//
//  RecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 07/04/24.
//

import UIKit
import Combine

final class RecipesTableViewDiffableDataSource: UITableViewDiffableDataSource<String?, Recipe> {}

//MARK: - Protocol
protocol RecipesViewModelProtocol: AnyObject {
    var hasFailure: CurrentValueSubject<Bool, Never> { get }
    var recipesDiffableDataSource: RecipesTableViewDiffableDataSource? { get set }
    var currentCuisineTypeIndex: Int { get set }
    
    func fetchRecipes(with cuisineTypeIndex: Int)
}

//MARK: - Implementation
final class RecipesViewModel: RecipesViewModelProtocol {
    
    //MARK: Properties
    let userInfoStorage: UserInfoStorageProtocol
    let recipesService: RecipesServiceProtocol
    
    var recipesDiffableDataSource: RecipesTableViewDiffableDataSource?
    private var snapshot = NSDiffableDataSourceSnapshot<String?, Recipe>()
    
    var hasFailure = CurrentValueSubject<Bool, Never>(false)
    var currentCuisineTypeIndex = 0
    
    private var subscriptions = Set<AnyCancellable>()

    //MARK: Init
    init(userInfoStorage: UserInfoStorageProtocol, recipesService: RecipesServiceProtocol) {
        self.userInfoStorage = userInfoStorage
        self.recipesService = recipesService
    }
    
    //MARK: Methods
    func fetchRecipes(with cuisineTypeIndex: Int) {
        Task {
            var endpoint = RecipesEndpoint()
            let cuisineType = getCuisineType(for: cuisineTypeIndex)
            endpoint.queryItems?.append(URLQueryItem(name: "cuisineType", value: cuisineType))
            endpoint.queryItems?.append(URLQueryItem(name: "diet", value: userInfoStorage.diet))
            
            let results = await recipesService.getRecipes(with: endpoint)
            switch results {
            case .success(let response):
                if cuisineTypeIndex != currentCuisineTypeIndex {
                    snapshot.deleteAllItems()
                }
                if snapshot.numberOfSections == 0 {
                    snapshot.appendSections([""])
                }
                
                response.hits.forEach { hit in
                    snapshot.appendItems([hit.recipe], toSection: "")
                }
                await recipesDiffableDataSource?.apply(snapshot, animatingDifferences: false)
            case .failure(_):
                hasFailure.send(true)
            }
        }
    }
    
    private func getCuisineType(for index: Int) -> String {
        switch index {
        case 0: return CuisineType.american.rawValue
        case 1: return CuisineType.italian.rawValue
        case 2: return CuisineType.chinese.rawValue
        default: return CuisineType.american.rawValue
        }
    }
    
}
