//
//  MainTabBarController.swift
//  WordzApp
//
//  Created by Mac-HOME on 12.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeCollectionViewController(collectionViewLayout: layout)
        
        homeController.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
        homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
        
        let settingController = SettingsViewController()
        
        settingController.tabBarItem.image = #imageLiteral(resourceName: "settings_unselected")
        settingController.tabBarItem.selectedImage = #imageLiteral(resourceName: "settings_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeController, settingController]
    }
}
