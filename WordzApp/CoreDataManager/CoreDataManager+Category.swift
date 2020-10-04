import UIKit
import CoreData

extension CoreDataManager {
    
    func addCategory(title: String, firstColor: UIColor, secondColor: UIColor, isHidden: Bool = false) {
        let context = persistentContainer.viewContext

        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)

        category.setValue(title, forKey: "title")
        category.setValue(firstColor, forKey: "firstColor")
        category.setValue(secondColor, forKey: "secondColor")
        category.setValue(isHidden, forKey: "isHidden")

        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save sentence: ", saveErr)
        }
    }
    
    func deleteCategory(category: Category) {
        let context = persistentContainer.viewContext
        context.delete(category)
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to delete level:", saveErr)
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
    
    func fetchNotHiddenCategories() -> [Category] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let categories = try context.fetch(fetchRequest)
            let notHiddenCategories = categories.filter { (categorie) -> Bool in
                return !categorie.isHidden
            }
            return notHiddenCategories
        } catch let fetchErr {
            print("Failed to fetch categories:", fetchErr)
            return []
        }
    }
    
    func fetchCategory(title: String) -> Category? {
        let categories = fetchCategories()
        
        let categorie = categories.filter { (categorie) -> Bool in
            return categorie.title == title
        }
        return categorie.first
    }
    
    // MARK: - Sentences
    
    func addSentence(text: String, translation: [String], category: Category?) {
        guard let category = category else { return }
        
        let context = persistentContainer.viewContext
        
        let sentence = NSEntityDescription.insertNewObject(forEntityName: "Sentence", into: context) as! Sentence
        
        sentence.category = category
        
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
    
    func isEmpty(category: Category?) -> Bool {
        guard let categorySentences = category?.sentences?.allObjects as? [Sentence] else { return true }
        return categorySentences.count == 0
    }
    
    func fetchSentences(category: Category?) -> [Sentence] {
        guard var categorySentences = category?.sentences?.allObjects as? [Sentence] else { return [] }
        
        categorySentences.sort { (first, second) -> Bool in
            return first.date! < second.date!
        }
        
        return categorySentences
    }
    
    func fetchNotLearnedSentences(category: Category?) -> [Sentence] {
        let sentences = fetchSentences(category: category)
        
        let notLearnedSentences = sentences.filter { (sentence) -> Bool in
            return !sentence.isLearned
        }
        
        return notLearnedSentences
    }
    
}
