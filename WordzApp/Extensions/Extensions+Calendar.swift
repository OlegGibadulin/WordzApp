//
//  Extensions+Calendar.swift
//  WordzApp
//
//  Created by Mac-HOME on 27.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

extension Calendar {
    
    // Get yesterday date
    func yesterday() -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day)
        
        let now = Date()
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now)
        
        return yesterday!
    }
    
    // Get today date
    func today() -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(0, for: .day)
        
        let now = Date()
        let today = Calendar.current.date(byAdding: dateComponents, to: now)
        
        return today!
    }
    
}
