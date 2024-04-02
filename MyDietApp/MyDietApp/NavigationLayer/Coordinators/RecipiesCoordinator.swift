//
//  RecipiesCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

protocol RecipiesCoordinatorProtocol: Coordinator {
    
}

final class RecipiesCoordinator: RecipiesCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators  = [Coordinator]()
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController()
        viewController.tabBarItem = UITabBarItem(title: Tab.recipies.getTitleName(),
                                                 image: UIImage(systemName: Tab.recipies.getIconName()),
                                                 tag: Tab.recipies.getIndex())
//        viewController.coordinator = self
        coordinatorFinishDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension RecipiesCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(coordinator: Coordinator) {
        childCoordinators.removeAll()
        navigationController.viewControllers.removeAll()
    }
}
