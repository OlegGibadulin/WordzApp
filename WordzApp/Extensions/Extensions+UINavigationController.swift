//
//  Extensions+UINavigationController.swift
//  WordzApp
//
//  Created by Mac-HOME on 16.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func transparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
}
