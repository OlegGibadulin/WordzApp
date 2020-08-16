//
//  SceneDelegate.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    fileprivate func initCoreData() {
        Storage.shared.deleteCategories()
        Storage.shared.uploadsCategories()
        
        Storage.shared.deleteLevels()
        Storage.shared.uploadLevels()
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        UINavigationBar.appearance().tintColor = .white
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().barTintColor = .lightRed
//        UINavigationBar.appearance().prefersLargeTitles = true
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
//        let layout = UICollectionViewFlowLayout()
//        let homeController = HomeCollectionViewController(collectionViewLayout: layout)
//        let homeController = CardsViewController()
//
        
//
//        let mainTabBarController = MainTabBarController()
//
//        let categoryViewController = CategoryViewController()
        
//        let layout = UICollectionViewFlowLayout()
//        let categoryViewController = CategoryCollectionViewController(collectionViewLayout: layout)
        
//        categoryViewController.categoryTitle = "Favourites"
        
//        let navController = CustomNavigationController(rootViewController: categoryViewController)
        
//        initCoreData()
        
        let homeViewController = HomeViewController()
        let categoryViewController = CategoryViewController()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = homeViewController
            self.window = window
            window.makeKeyAndVisible()
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
