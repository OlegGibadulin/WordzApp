//
//  Storage+Sentence.swift
//  WordzApp
//
//  Created by Mac-HOME on 09.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

extension Storage {
    
    func uploadSentences(level: Level) {
        CoreDataManager.shared.addSentence(text: "Word", translation: ["Слово"], level: level)
        CoreDataManager.shared.addSentence(text: "Sentence", translation: ["Предложение"], level: level)

        CoreDataManager.shared.addSentence(text: "Another word", translation: ["Другое слово"], level: level)
        CoreDataManager.shared.addSentence(text: "Another sentence", translation: ["Другое предложение"], level: level)

        CoreDataManager.shared.addSentence(text: "appearance", translation: ["внешний вид", "появление"], level: level)
        CoreDataManager.shared.addSentence(text: "aggregate", translation: ["заполнитель (бетона)"], level: level)
        CoreDataManager.shared.addSentence(text: "conditioning", translation: ["регулирование влажности температуры"], level: level)
        CoreDataManager.shared.addSentence(text: "conduit", translation: ["водопроводная труба"], level: level)
        
        CoreDataManager.shared.addSentence(text: "Longsdjdskgdsldsgjdslgdsjsdgjdslsd", translation: ["Longsd jdskgd slds gjdsl gdsj sdgjds lsd kgsdg ldsgj dskg jsdg lsd asfsaf"], level: level)
    }
    
    func deleteSentences(level: Level) {
        let sentences = CoreDataManager.shared.fetchSentences(level: level)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
}
