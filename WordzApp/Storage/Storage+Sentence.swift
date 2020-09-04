//
//  Storage+Sentence.swift
//  WordzApp
//
//  Created by Mac-HOME on 09.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

extension Storage {
    
    func uploadSentences(levelTitle: String, sentences: [String:[String]]?) {
        guard let level = CoreDataManager.shared.fetchLevel(title: levelTitle), let sentences = sentences else { return }
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.addSentence(text: sentence.key, translation: sentence.value, level: level)
        }
    }
    
    func uploadSentences(category: Category?, sentences: [String:[String]]?) {
        guard let category = category, let sentences = sentences else { return }
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.addSentence(text: sentence.key, translation: sentence.value, category: category)
        }
    }
    
    func deleteSentences(level: Level) {
        let sentences = CoreDataManager.shared.fetchSentences(level: level)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
    func deleteSentences(category: Category) {
        let sentences = CoreDataManager.shared.fetchSentences(category: category)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
}
