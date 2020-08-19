//
//  CardsUserDefaults.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

final class CardsSettings {
    private enum CardSettings: String {
        case сardsInPack
        case сardsRepeats
    }
    
    static var сardsInPack: Int! {
        get {
            if (UserDefaults.standard.integer(forKey: CardSettings.сardsInPack.rawValue) == 0) {
                return 15
            }
            return UserDefaults.standard.integer(forKey: CardSettings.сardsInPack.rawValue)
        }
        
        set {
            
            let defaults = UserDefaults.standard
            let key = CardSettings.сardsInPack.rawValue
            if (newValue >= 10 || newValue <= 25) {
                defaults.set(newValue, forKey: key)
            } else {
                defaults.set(15, forKey: key)
            }
        }
    }
    
    static var сardsRepeats: Int {
        get {
            if (UserDefaults.standard.integer(forKey: CardSettings.сardsRepeats.rawValue) == 0) {
                return 1
            }
            return UserDefaults.standard.integer(forKey: CardSettings.сardsRepeats.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = CardSettings.сardsRepeats.rawValue
            if (newValue >= 1 || newValue <= 5) {
                defaults.set(newValue, forKey: key)
            } else {
                defaults.set(1, forKey: key)
            }
        }
    }
}
