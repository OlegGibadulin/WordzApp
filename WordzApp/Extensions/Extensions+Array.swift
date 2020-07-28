//
//  Extensions+Array.swift
//  WordzApp
//
//  Created by Mac-HOME on 27.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

extension Array {
    
    // Picks n random elements
    subscript (randomPick n: Int) -> [Element] {
        if count <= n {
            return self.shuffled()
        }
        var indices = [Int](0..<count)
        var randoms = [Int]()
        for _ in 0..<n {
            randoms.append(indices.remove(at: Int(arc4random_uniform(UInt32(indices.count)))))
        }
        return randoms.map { self[$0] }
    }
    
}
