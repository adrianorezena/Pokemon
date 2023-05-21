//
//  SceneDelegate.swift
//  Pokemon
//
//  Created by Adriano Rezena on 19/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var homeCoordinator: HomeCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController: UINavigationController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator?.start()
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

}

