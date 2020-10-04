import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: uncomment this if you want to reset data in CoreData
//        let defaults = UserDefaults.standard
//        defaults.set(false, forKey: "isFilledCoreData")
        
        fillCoreData()
        
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

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
