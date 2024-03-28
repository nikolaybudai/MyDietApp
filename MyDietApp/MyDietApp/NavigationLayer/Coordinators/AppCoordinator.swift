//
//  AppCoordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

protocol AppCoordinatorProtocol: CoordinatorProtocol {
    func showMainFlow()
}

//final class AppCoordinator: Coordinator {
//    
//    override func start() {
//        
//    }
//    
//    override func finish() {
//        print("Finish AppCoordinator")
//    }
//}

class AppCoordinator: AppCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType { .app }
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainFlow()
    }
    
    func showMainFlow() {
        let tabCoordinator = TabBarCoordinator(navigationController: navigationController)
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

//private extension AppCoordinator {
//    func showMainFlow() {
//        let homeNavigationController = UINavigationController()
//        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
//        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.init(systemName: "swirl.circle.righthalf.filled"), tag: 0)
//        homeCoordinator.finishDelegate = finishDelegate
//        homeCoordinator.start()
        
//        let orderNavigationController = UINavigationController()
//        let orderCoordinator = OrderCoordinator(type: .order, navigationController: orderNavigationController)
//        orderNavigationController.tabBarItem = UITabBarItem(title: "Order", image: UIImage.init(systemName: "swirl.circle.righthalf.filled"), tag: 1)
//        orderCoordinator.finishDelegate = finishDelegate
//        orderCoordinator.start()
        
//        let listNavigationController = UINavigationController()
//        let listCoordinator = ListCoordinator(type: .list, navigationController: listNavigationController)
//        listNavigationController.tabBarItem = UITabBarItem(title: "List", image: UIImage.init(systemName: "swirl.circle.righthalf.filled"), tag: 2)
//        listCoordinator.finishDelegate = finishDelegate
//        listCoordinator.start()
        
//        let profileNavigationController = UINavigationController()
//        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
//        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "swirl.circle.righthalf.filled"), tag: 3)
//        profileCoordinator.finishDelegate = finishDelegate
//        profileCoordinator.start()
        
//        coordinator.addChildCoordinator(homeCoordinator)
//        coordinator.addChildCoordinator(orderCoordinator)
//        coordinator.addChildCoordinator(listCoordinator)
//        coordinator.addChildCoordinator(profileCoordinator)
//        
//        let tabBarControllers = [homeNavigationController, orderNavigationController, listNavigationController, profileNavigationController]
//        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
//        
//        return tabBarController
                
//    }
//}

//extension AppCoordinator: CoordinatorFinishDelegate {
//    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
//        removeChildCoordinator(childCoordinator)
//        
//        switch childCoordinator.type {
//        case .app:
//            return
//        default:
//            navigationController?.popViewController(animated: false)
//        }
//    }
//}
