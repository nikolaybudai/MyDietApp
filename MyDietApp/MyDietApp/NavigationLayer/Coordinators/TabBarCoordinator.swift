//
//  TabBarCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

enum Tab {
    case recipies
    case myRecipies
    case profile
    
    func getIndex() -> Int {
        switch self {
        case .recipies: return 0
        case .myRecipies: return 1
        case .profile: return 2
        }
    }

    func getTitleName() -> String {
        switch self {
        case .recipies: return "Recipies"
        case .myRecipies: return "My Recipies"
        case .profile: return "Profile"
        }
    }

    func getIconName() -> String {
        switch self {
        case .recipies: return "fork.knife.circle"
        case .myRecipies: return "bookmark.circle"
        case .profile: return "person.crop.circle"
        }
    }
}

protocol TabBarCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var tabBarController: UITabBarController
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType { .mainTab }
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabBarController = UITabBarController()
    }
    
    func start() {
        let tabs: [Tab] = [.recipies, .myRecipies, .profile]
        let controllers: [UINavigationController] = tabs.map { getTabBarController($0) }
        prepareTabBarController(withTabControllers: controllers)
    }
    
}

private extension TabBarCoordinator {
    
    func getTabBarController(_ tab: Tab) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: tab.getTitleName(),
                                                       image: UIImage(systemName: tab.getIconName()),
                                                       tag: tab.getIndex())
        switch tab {
        case .recipies:
            let coordinator = RecipiesCoordinator(navigationController: navigationController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .myRecipies:
            let coordinator = MyRecipiesCoordinator(navigationController: navigationController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .profile:
            let coordinator = ProfileCoordinator(navigationController: navigationController)
            coordinator.start()
            childCoordinators.append(coordinator)
        }
        
        return navigationController
    }
    
    func prepareTabBarController(withTabControllers tabBarControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabBarControllers, animated: true)
        tabBarController.selectedIndex = Tab.recipies.getIndex()
        tabBarController.tabBar.tintColor = AppColors.highlightYellow
        tabBarController.tabBar.unselectedItemTintColor = AppColors.baseCyan
        tabBarController.tabBar.backgroundColor = AppColors.background
        
        navigationController.viewControllers = [tabBarController]
    }
}
