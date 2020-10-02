//
//  MainTabBarController.swift
//  WordzApp
//
//  Created by Mac-HOME on 12.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class LeftAlignedViewFlowLayout : UICollectionViewFlowLayout {

    let cellSpacing:CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
//        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left)
//        let alignedFlowLayout = LeftAlignedViewFlowLayout()
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
