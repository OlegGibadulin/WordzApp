//
//  Storage.swift
//  WordzApp
//
//  Created by Mac-HOME on 27.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

struct Storage {
    
    static func uploadLevels() {
        CoreDataManager.shared.addLevel(title: "Beginner")
        CoreDataManager.shared.addLevel(title: "Intermediate")
        CoreDataManager.shared.addLevel(title: "Advanced")
    }
    
    static func deleteLevels() {
        let levels = CoreDataManager.shared.fetchLevels()
        levels.forEach { (level) in
            CoreDataManager.shared.deleteLevel(level: level)
        }
    }
    
    static func uploadSentences(level: Level) {
        CoreDataManager.shared.addSentence(text: "Word", translation: ["Слово"], level: level)
        CoreDataManager.shared.addSentence(text: "Sentence", translation: ["Предложение"], level: level)
        
        CoreDataManager.shared.addSentence(text: "Another word", translation: ["Другое слово"], level: level)
        CoreDataManager.shared.addSentence(text: "Another sentence", translation: ["Другое предложение"], level: level)
        
        CoreDataManager.shared.addSentence(text: "appearance", translation: ["внешний вид", "появление"], level: level)
        CoreDataManager.shared.addSentence(text: "aggregate", translation: ["заполнитель (бетона)"], level: level)
        CoreDataManager.shared.addSentence(text: "conditioning", translation: ["регулирование влажности температуры"], level: level)
        CoreDataManager.shared.addSentence(text: "conduit", translation: ["водопроводная труба"], level: level)
    }
    
    static func deleteSentences(level: Level) {
        let sentences = CoreDataManager.shared.fetchSentences(level: level)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
    static func uploadsCategories() {
        CoreDataManager.shared.addCategory(title: "Today", firstColor: .lightRed, secondColor: .lightBlue)
        CoreDataManager.shared.addCategory(title: "Favourites", firstColor: .lightRed, secondColor: .lightBlue)
        CoreDataManager.shared.addCategory(title: "Computer", firstColor: .lightRed, secondColor: .lightBlue)
    }
    
    static func deleteCategories() {
        let categories = CoreDataManager.shared.fetchCategories()
        categories.forEach { (category) in
            CoreDataManager.shared.deleteCategory(category: category)
        }
    }
    
}
