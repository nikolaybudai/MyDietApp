//
//  SceneDelegate.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        let userInfoStorage = UserInfoStorage()
        appCoordinator = AppCoordinator(tabBarController: tabBarController,
                                        userInfoStorage: userInfoStorage)
        appCoordinator?.start()
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }


}

