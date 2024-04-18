//
//  RecipesViewModel.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 07/04/24.
//

import UIKit
import Combine

enum Section {
    case recipe
}

//MARK: - Protocol
protocol RecipesViewModelProtocol: AnyObject, UITableViewDelegate {
    var hasFailure: CurrentValueSubject<Bool, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var recipesDiffableDataSource: UITableViewDiffableDataSource<Section, Recipe>? { get set }
    var currentCuisineTypeIndex: Int { get set }
    var isLoadingMoreRecipes: Bool { get set }
    var currentNextEndpoint: RecipesEndpoint? { get set }
    
    func fetchRecipes(with cuisineTypeIndex: Int)
    func fetchMoreRecipes(with newEndpoint: RecipesEndpoint)
}

//MARK: - Implementation
final class RecipesViewModel: NSObject, RecipesViewModelProtocol {
    
    //MARK: Properties
    let userInfoStorage: UserInfoStorageProtocol
    let recipesService: RecipesServiceProtocol
    
    var recipesDiffableDataSource:  UITableViewDiffableDataSource<Section, Recipe>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
    
    var hasFailure = CurrentValueSubject<Bool, Never>(false)
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var currentCuisineTypeIndex: Int = 0
    var currentNextEndpoint: RecipesEndpoint?
    var isLoadingMoreRecipes = false
    
    private var subscriptions = Set<AnyCancellable>()

    //MARK: Init
    init(userInfoStorage: UserInfoStorageProtocol, recipesService: RecipesServiceProtocol) {
        self.userInfoStorage = userInfoStorage
        self.recipesService = recipesService
    }
    
    //MARK: Methods
    func fetchRecipes(with cuisineTypeIndex: Int) {
        isLoading.send(true)
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
                    snapshot.appendSections([.recipe])
                }
                
                response.hits.forEach { hit in
                    snapshot.appendItems([hit.recipe], toSection: .recipe)
                }
                await recipesDiffableDataSource?.apply(snapshot, animatingDifferences: false)
                
                let newUrl = response.links.next.href
                guard let url = URL(string: newUrl) else { return }
                currentNextEndpoint = endpoint.nextURL(url)
                
                isLoading.send(false)
            case .failure(_):
                hasFailure.send(true)
                isLoading.send(false)
            }
            
            currentCuisineTypeIndex = cuisineTypeIndex
        }
    }
    
    func fetchMoreRecipes(with newEndpoint: RecipesEndpoint) {
        guard !isLoadingMoreRecipes else { return }
        guard let nextEndpoint = currentNextEndpoint else {
            isLoadingMoreRecipes = false
            return
        }
        isLoadingMoreRecipes = true
        isLoading.send(true)
        
        Task {
            let newResponse = await recipesService.getRecipes(with: nextEndpoint)
            switch newResponse {
            case .success(let response):
                response.hits.forEach { hit in
                    snapshot.appendItems([hit.recipe], toSection: .recipe)
                }
                await recipesDiffableDataSource?.apply(snapshot, animatingDifferences: false)
                isLoadingMoreRecipes = false
                
                let newUrl = response.links.next.href
                guard let url = URL(string: newUrl) else { return }
                currentNextEndpoint = nextEndpoint.nextURL(url)
                
                isLoading.send(false)
            case .failure(_):
                hasFailure.send(true)
                isLoadingMoreRecipes = false
                isLoading.send(false)
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

//extension RecipesViewModel: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard !isLoadingMoreRecipes else { return }
//        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
//            let offset = scrollView.contentOffset.y
//            let totalContentheight = scrollView.contentSize.height
//            let totalScrollViewFixedHeight = scrollView.frame.size.height
//
//            if offset >= (totalContentheight - totalScrollViewFixedHeight - 120) {
//                guard let newEnpoint = self?.currentNextEndpoint else { return }
//                self?.fetchMoreRecipes(with: newEnpoint)
//            }
//            timer.invalidate()
//        }
//    }
//}