//
//  ProfileCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

final class ProfileCoordinator: CoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tabItem
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userInfoStorage = UserInfoStorage()
        let viewModel = ProfileViewModel(userInfoStorage: userInfoStorage)
        let viewController = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension ProfileCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
