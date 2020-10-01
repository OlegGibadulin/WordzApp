//
//  PurchasesUserDefaults.swift
//  WordzApp
//
//  Created by Антон Тимонин on 01.10.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

class Purchases {
    private enum PurchasesEnum: String {
        case fullVersion
    }
    
    static var fullVersion: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: PurchasesEnum.fullVersion.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = PurchasesEnum.fullVersion.rawValue
            if newValue == true {
                defaults.set(newValue, forKey: key)
            }
        }
    }
}
