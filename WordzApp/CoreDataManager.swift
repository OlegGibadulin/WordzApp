//
//  CoreDataManager.swift
//  WordzApp
//
//  Created by Mac-HOME on 22.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let pc = NSPersistentContainer(name: "WordzAppModels")
        pc.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return pc
    }()
    
    func fetchSentences(category: Category?) -> [Sentence] {
        guard let categorySentences = category?.sentences?.allObjects as? [Sentence] else { return [] }
        
        return categorySentences
    }
    
    func addSentence(text: String, translation: String, category: Category?) {
        guard let category = category else { return }
        
        let context = persistentContainer.viewContext
        
        let sentence = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context) as! Sentence
        
        sentence.category = category
        
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
    
    func fetchCategories() -> [Category] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let categories = try context.fetch(fetchRequest)
            return categories
        } catch let fetchErr {
            print("Failed to fetch categories:", fetchErr)
            return []
        }
    }
    
    func addCategory(title: String, firstColor: UIColor, secondColor: UIColor) {
        let context = persistentContainer.viewContext

        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)

        category.setValue(title, forKey: "title")
        category.setValue(firstColor, forKey: "firstColor")
        category.setValue(secondColor, forKey: "secondColor")

        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save sentence: ", saveErr)
        }
    }
}
