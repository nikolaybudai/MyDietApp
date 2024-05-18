//
//  AppCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }
    var userInfoStorage: UserInfoStorageProtocol { get }
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    let tabBarController: UITabBarController
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let userInfoStorage: UserInfoStorageProtocol
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(tabBarController: UITabBarController, userInfoStorage: UserInfoStorageProtocol) {
        self.tabBarController = tabBarController
        self.userInfoStorage = userInfoStorage
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let recipiesCoordinator = RecipiesCoordinator(navigationController: UINavigationController())
        let myRecipiesCoordinator = MyRecipiesCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        
        childCoordinators.append(recipiesCoordinator)
        childCoordinators.append(myRecipiesCoordinator)
        childCoordinators.append(profileCoordinator)
        
        recipiesCoordinator.start()
        myRecipiesCoordinator.start()
        profileCoordinator.start()
        
        tabBarController.setViewControllers([recipiesCoordinator.navigationController,
                                             myRecipiesCoordinator.navigationController,
                                             profileCoordinator.navigationController], animated: false)
        
        setupTabBar(tabBarController: tabBarController)
    }
    
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(coordinator: Coordinator) {
        childCoordinators.removeAll()
        tabBarController.viewControllers?.removeAll()
    }
}

private extension AppCoordinator {
    func setupTabBar(tabBarController: UITabBarController) {
        tabBarController.tabBar.tintColor = AppColors.highlightYellow
        tabBarController.tabBar.unselectedItemTintColor = AppColors.baseCyan
        tabBarController.tabBar.backgroundColor = AppColors.background
        
        if userInfoStorage.hasFilledData {
            tabBarController.selectedIndex = Tab.recipies.getIndex()
        } else {
            tabBarController.selectedIndex = Tab.profile.getIndex()
        }
    }
}
