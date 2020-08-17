//
//  Etensions+UIButton.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBlueStyle() {
        backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        layer.cornerRadius = 8
        layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func setRedStyle() {
        backgroundColor = .lightRed
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}
