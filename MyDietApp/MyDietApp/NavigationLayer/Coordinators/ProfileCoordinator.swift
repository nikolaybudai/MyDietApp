//
//  ProfileCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/03/24.
//

import UIKit

protocol ProfileCoordinatorProtocol: Coordinator {
    
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators  = [Coordinator]()
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userInfoStorage = UserInfoStorage()
        let viewModel = ProfileViewModel(userInfoStorage: userInfoStorage)
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(title: Tab.profile.getTitleName(),
                                                 image: UIImage(systemName: Tab.profile.getIconName()),
                                                 tag: Tab.profile.getIndex())
        viewController.coordinator = self
        coordinatorFinishDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension ProfileCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(coordinator: Coordinator) {
        childCoordinators.removeAll()
        navigationController.viewControllers.removeAll()
    }
}
