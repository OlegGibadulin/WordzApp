//
//  CoreDataManager+Level.swift
//  WordzApp
//
//  Created by Mac-HOME on 24.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import CoreData

extension CoreDataManager {
    
    func addLevel(title: String) {
        let context = persistentContainer.viewContext

        let level = NSEntityDescription.insertNewObject(forEntityName: "Level", into: context)

        level.setValue(title, forKey: "title")
        level.setValue(Calendar.current.yesterday(), forKey: "uploadDate")

        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save sentence: ", saveErr)
        }
    }
    
    func deleteLevel(level: Level) {
        let context = persistentContainer.viewContext
        context.delete(level)
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to delete level:", saveErr)
        }
    }
    
    func fetchLevels() -> [Level] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Level>(entityName: "Level")
        
        do {
            let levels = try context.fetch(fetchRequest)
            return levels
        } catch let fetchErr {
            print("Failed to fetch levels:", fetchErr)
            return []
        }
    }
    
    func fetchLevel(title: String) -> Level? {
        let levels = fetchLevels()
        
        let level = levels.filter { (level) -> Bool in
            return level.title == title
        }
        return level.first
    }
    
    func updateDate(level: Level) {
        let context = persistentContainer.viewContext
        level.uploadDate = Calendar.current.today()
        
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit sentence:", editErr)
        }
    }
    
    // MARK: - Sentences
    
    func addSentence(text: String, translation: [String], level: Level?) {
        guard let level = level else { return }
        
        let context = persistentContainer.viewContext
        
        let sentence = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context) as! Sentence
        
        sentence.level = level
        
        sentence.setValue(text, forKey: "text")
        sentence.setValue(translation, forKey: "translation")
        sentence.setValue(false, forKey: "isLearned")
        sentence.setValue(false, forKey: "isFavourite")
        sentence.setValue(0, forKey: "learned")
        sentence.setValue(Calendar.current.today(), forKey: "date")
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save sentence: ", saveErr)
        }
    }
    
    func fetchSentences(level: Level?) -> [Sentence] {
        guard let levelSentences = level?.sentences?.allObjects as? [Sentence] else { return [] }
        
        return levelSentences
    }
    
    func fetchNotLearnedSentences(level: Level?) -> [Sentence] {
        let sentences = fetchSentences(level: level)
        
        let notLearnedSentences = sentences.filter { (sentence) -> Bool in
            return !sentence.isLearned
        }
        
        return notLearnedSentences
    }
    
}
