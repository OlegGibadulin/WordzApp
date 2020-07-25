//
//  CoreDataManager+Level.swift
//  WordzApp
//
//  Created by Mac-HOME on 24.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import CoreData

extension CoreDataManager {
    
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
    
    func addLevel(title: String) {
        let context = persistentContainer.viewContext

        let level = NSEntityDescription.insertNewObject(forEntityName: "Level", into: context)

        level.setValue(title, forKey: "title")

        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save sentence: ", saveErr)
        }
    }
    
    func addSentence(text: String, translation: String, level: Level?) {
        guard let level = level else { return }
        
        let context = persistentContainer.viewContext
        
        let sentence = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context) as! Sentence
        
        sentence.level = level
        
        sentence.setValue(text, forKey: "text")
        sentence.setValue(translation, forKey: "translation")
        sentence.setValue(false, forKey: "isLearned")
        sentence.setValue(false, forKey: "isFavourite")
        
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
    
}
