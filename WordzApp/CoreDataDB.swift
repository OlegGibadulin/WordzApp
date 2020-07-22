//
//  CoreDataDB.swift
//  WordzApp
//
//  Created by Mac-HOME on 22.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import CoreData

class CoreDataDB {
    static func addSentence(text: String, translation: String) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let sentence = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context)
        
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
}
