//
//  RecipiesCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

protocol RecipiesCoordinatorProtocol: Coordinator {
    func showRecipeDetail(recipe: Recipe)
}

final class RecipiesCoordinator: RecipiesCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators  = [Coordinator]()
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userInfoStorage = UserInfoStorage()
        let service = RecipesService()
        let viewModel = RecipesViewModel(userInfoStorage: userInfoStorage, recipesService: service)
        let viewController = RecipesViewController(viewModel: viewModel)
        viewController.coordinator = self
        viewController.tabBarItem = UITabBarItem(title: Tab.recipies.getTitleName(),
                                                 image: UIImage(systemName: Tab.recipies.getIconName()),
                                                 tag: Tab.recipies.getIndex())
        coordinatorFinishDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showRecipeDetail(recipe: Recipe) {
        let viewModel = RecipeDetailViewModel(recipe: recipe)
        let viewController = RecipeDetailViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension RecipiesCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(coordinator: Coordinator) {
        childCoordinators.removeAll()
        navigationController.viewControllers.removeAll()
    }
}
