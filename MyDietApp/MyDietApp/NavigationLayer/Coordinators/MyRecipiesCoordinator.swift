//
//  MyRecipiesCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

protocol MyRecipiesCoordinatorProtocol: Coordinator {
    
}

final class MyRecipiesCoordinator: MyRecipiesCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators  = [Coordinator]()
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController()
        viewController.tabBarItem = UITabBarItem(title: Tab.myRecipies.getTitleName(),
                                                 image: UIImage(systemName: Tab.myRecipies.getIconName()),
                                                 tag: Tab.myRecipies.getIndex())
//        viewController.coordinator = self
        coordinatorFinishDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension MyRecipiesCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(coordinator: Coordinator) {
        childCoordinators.removeAll()
        navigationController.viewControllers.removeAll()
    }
}
