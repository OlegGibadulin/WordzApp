//
//  Extensions+UIColor.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

extension UIColor {
    static let tealColor = rgb(red: 48, green: 164, blue: 182)
    static let lightRed = rgb(red: 247, green: 66, blue: 82)
    static let darkBlue = rgb(red: 9, green: 45, blue: 64)
    static let lightBlue = rgb(red: 218, green: 235, blue: 243)
    static let limeGreen = rgb(red: 50, green: 205, blue: 50)
    static let darkGreen = rgb(red: 29, green: 186, blue: 8)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
