//
//  Storage+Level.swift
//  WordzApp
//
//  Created by Mac-HOME on 09.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

struct LevelStorage {
    let title: String
    let sentences: [String:[String]]?
}

extension Storage {
    
    func uploadLevels() {
        levels.forEach { (level) in
            CoreDataManager.shared.addLevel(title: level.title)
        }
    }
    
    func deleteLevels() {
        let levels = CoreDataManager.shared.fetchLevels()
        levels.forEach { (level) in
            deleteSentences(level: level)
            CoreDataManager.shared.deleteLevel(level: level)
        }
    }
    
//    func uploadSentences(level: Level) {
//        uploadSentences(levelTitle: level.title, sentences: level.sentences)
//    }
    
}
