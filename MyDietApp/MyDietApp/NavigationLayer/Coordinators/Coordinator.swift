//
//  Coordinator.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var coordinatorFinishDelegate: CoordinatorFinishDelegate? { get set }
        
    func start()
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(coordinator: Coordinator)
}
