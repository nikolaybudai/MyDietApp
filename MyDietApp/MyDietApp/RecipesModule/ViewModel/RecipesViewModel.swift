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
    var cuisineType: String { get set }
    var recipesDiffableDataSource: RecipesTableViewDiffableDataSource? { get set }
    
    func fetchRecipes()
}

//MARK: - Implementation
final class RecipesViewModel: RecipesViewModelProtocol {
    
    //MARK: Properties
    let userInfoStorage: UserInfoStorageProtocol
    let recipesService: RecipesServiceProtocol
    
    var recipesDiffableDataSource: RecipesTableViewDiffableDataSource?
    private var snapshot = NSDiffableDataSourceSnapshot<String?, Recipe>()
    
    var hasFailure = CurrentValueSubject<Bool, Never>(false)
    var cuisineType: String = CuisineType.american.rawValue

    //MARK: Init
    init(userInfoStorage: UserInfoStorageProtocol, recipesService: RecipesServiceProtocol) {
        self.userInfoStorage = userInfoStorage
        self.recipesService = recipesService
    }
    
    //MARK: Methods
    func fetchRecipes() {
        Task {
            var endpoint = RecipesEndpoint()
            endpoint.queryItems?.append(URLQueryItem(name: "cuisineType", value: cuisineType))
            endpoint.queryItems?.append(URLQueryItem(name: "diet", value: userInfoStorage.diet))
            
            let results = await recipesService.getRecipes(with: endpoint)
            switch results {
            case .success(let response):
                snapshot.appendSections([""])
                response.hits.forEach { hit in
                    snapshot.appendItems([hit.recipe], toSection: "")
                }
                await recipesDiffableDataSource?.apply(snapshot, animatingDifferences: false)
            case .failure(_):
                hasFailure.send(true)
            }
        }
    }
    
}
