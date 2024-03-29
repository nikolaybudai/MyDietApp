//
//  MyRecipiesCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

final class MyRecipiesCoordinator: CoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tabItem
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myRecipiesViewController = ViewController()
        navigationController.pushViewController(myRecipiesViewController, animated: true)
    }
    
}

extension MyRecipiesCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
