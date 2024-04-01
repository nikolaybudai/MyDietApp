//
//  AppCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType { .app }
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userInfoStorage = UserInfoStorage()
        let tabCoordinator = TabBarCoordinator(navigationController: navigationController, userInfoStorage: userInfoStorage)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
    
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
