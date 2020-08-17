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
    
    // MARK: - Sentences
    
    func fetchSentences() -> [Sentence] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Sentence>(entityName: "Sentence")
        
        do {
            let sentences = try context.fetch(fetchRequest)
            return sentences
        } catch let fetchErr {
            print("Failed to fetch sentences:", fetchErr)
            return []
        }
    }
    
    func deleteFavoriteSentence(sentence: Sentence) {
        let context = persistentContainer.viewContext
        
        let allSentences = fetchSentences()
        let equalSentences = allSentences.filter { (probSentence) -> Bool in
            return probSentence.isFavourite && probSentence.text == sentence.text && probSentence.translation == sentence.translation
        }
        
        if let equalSentence = equalSentences.first {
            equalSentence.isFavourite = false
        }
        
        context.delete(sentence)
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to delete sentence:", saveErr)
        }
    }
    
    func deleteSentence(sentence: Sentence) {
        let context = persistentContainer.viewContext
        context.delete(sentence)
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to delete sentence:", saveErr)
        }
    }
    
    func learnSentence(sentence: Sentence) {
        let context = persistentContainer.viewContext
        sentence.isLearned = true
        
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit sentence:", editErr)
        }
    }
    
    func favouriteSentence(sentence: Sentence) {
        let context = persistentContainer.viewContext
        
        let favouritesTitle = Storage.shared.favouritesTitle
        guard let category = CoreDataManager.shared.fetchCategory(title: favouritesTitle) else { return }
        
        guard let text = sentence.text, let translation = sentence.translation else { return }
        
        if !sentence.isFavourite {
            // Add sentence to Favourites category
            addSentence(text: text, translation: translation, category: category)
        } else {
            // Get sentences from Favourites category
            let sentences = fetchSentences(category: category)
            
            // Find that sentences there
            let favouritesSentences = sentences.filter { (sentence) -> Bool in
                return sentence.text == text && sentence.translation == translation
            }
            guard let sentence = favouritesSentences.first else { return }
            
            // Delete it
            deleteSentence(sentence: sentence)
        }
        
        sentence.isFavourite = !sentence.isFavourite
        
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit sentence:", editErr)
        }
    }
    
    func fetchFavouritesSentences() -> [Sentence] {
        let sentences = fetchSentences()
        
        let favouritesSentences = sentences.filter { (sentence) -> Bool in
            return sentence.isFavourite
        }
        
        return favouritesSentences
    }
}
