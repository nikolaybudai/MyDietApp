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
        case .recipies: return ""
        case .myRecipies: return ""
        case .profile: return ""
        }
    }
}

protocol TabBarCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
//    func selectPage(_ page: Tab)
//    func setSelectedIndex(_ index: Int)
//    func currentPage() -> Tab?
}

class TabBarCoordinator: TabBarCoordinatorProtocol {
    
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
                                                       image: UIImage(named: tab.getIconName()),
                                                       tag: tab.getIndex())
        switch tab {
        case .recipies:
            break
//            let coordinator = HomeCoordinator(navController)
//            coordinator.start()
//            childCoordinators.append(coordinator)
        case .myRecipies:
            break
//            let coordinator = HomeCoordinator(navController)
//            coordinator.start()
//            childCoordinators.append(coordinator)
        case .profile:
            break
//            let coordinator = ProfileCoordinator(navController)
//            coordinator.start()
//            childCoordinators.append(coordinator)
        }
        
        return navigationController
    }
    
    func prepareTabBarController(withTabControllers tabBarControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabBarControllers, animated: true)
        tabBarController.selectedIndex = Tab.recipies.getIndex()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
}
