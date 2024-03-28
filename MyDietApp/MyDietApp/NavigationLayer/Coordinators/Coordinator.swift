//
//  Coordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

enum CoordinatorType {
    case app
    case mainTab
    case tabItem
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigationController: UINavigationController { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

//protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
//    var tabBarController: UITabBarController? { get set }
//}

//class Coordinator: CoordinatorProtocol {
//    
//    var childCoordinators: [CoordinatorProtocol]
//    var type: CoordinatorType
//    var navigationController: UINavigationController?
//    var finishDelegate: CoordinatorFinishDelegate?
//    
//    init(childCoordinators: [CoordinatorProtocol], type: CoordinatorType, navigationController: UINavigationController? = nil, finishDelegate: CoordinatorFinishDelegate? = nil) {
//        self.childCoordinators = childCoordinators
//        self.type = type
//        self.navigationController = navigationController
//        self.finishDelegate = finishDelegate
//    }
//    
//    deinit {
//        print("Deinit coordinator \(type)")
//        childCoordinators.forEach { $0.finishDelegate = nil }
//        childCoordinators.removeAll()
//    }
//    
//    func start() {
//        print("Start coordinator")
//    }
//    
//    func finish() {
//        print("Finish coordinator")
//    }
//    
//}
