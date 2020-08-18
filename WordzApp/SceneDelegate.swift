//
//  SceneDelegate.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // TODO: delete this
        // defaults.set(false, forKey: "isFilledCoreData")
        fillCoreData()
        
//        let layout = UICollectionViewFlowLayout()
//        let homeCollectionViewController = HomeCollectionViewController(collectionViewLayout: layout)
//        let homeNavController = UINavigationController(rootViewController: homeCollectionViewController)
//        homeNavController.transparentNavigationBar()
        
        let homeViewController = HomeViewController()
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        homeNavController.transparentNavigationBar()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = homeNavController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    fileprivate func fillCoreData() {
        let defaults = UserDefaults.standard
        let isFilled = defaults.bool(forKey: "isFilledCoreData")
        
        if !isFilled {
            Storage.shared.deleteCategories()
            Storage.shared.uploadsCategories()
            
            Storage.shared.deleteLevels()
            Storage.shared.uploadLevels()
            
            defaults.set(true, forKey: "isFilledCoreData")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
