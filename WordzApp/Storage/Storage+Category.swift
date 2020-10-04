import UIKit

struct CategoryStorage {
    let title: String
    let firstColor: UIColor
    let secondColor: UIColor
    let sentences: [String:[String]]?
    let isHidden: Bool
    
    init(title: String, firstColor: UIColor = .white, secondColor: UIColor = .white, sentences: [String:[String]]? = nil, isHidden: Bool = false) {
        self.title = title
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.sentences = sentences
        self.isHidden = isHidden
    }
}

extension Storage {
    
    mutating func uploadsCategories() {
        uploadsCategories(categories: categories)
        uploadsCategories(categories: categoriesForLevels)
    }
    
    mutating fileprivate func uploadsCategories(categories: [CategoryStorage]) {
        categories.forEach { (category) in
            CoreDataManager.shared.addCategory(title: category.title, firstColor: category.firstColor, secondColor: category.secondColor, isHidden: category.isHidden)
        }
    }
    
    func deleteCategories() {
        let categories = CoreDataManager.shared.fetchCategories()
        categories.forEach { (category) in
            deleteSentences(category: category)
            CoreDataManager.shared.deleteCategory(category: category)
        }
    }
    
    mutating func uploadSentences(category: Category?) {
        guard let category = category else { return }
        
        // Search category storage by title
        let categoryStorage = self.categories.filter { (categoryStorage) -> Bool in
            return categoryStorage.title == category.title
        }.first
        
        guard let uploadedCategory = categoryStorage else { return }
        uploadSentences(category: category, sentences: uploadedCategory.sentences)
    }
    
}
