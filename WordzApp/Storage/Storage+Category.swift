//
//  Storage+Category.swift
//  WordzApp
//
//  Created by Mac-HOME on 09.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

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
            
            uploadSentences(categoryTitle: category.title, sentences: category.sentences)
        }
    }
    
    func deleteCategories() {
        let categories = CoreDataManager.shared.fetchCategories()
        categories.forEach { (category) in
            deleteSentences(category: category)
            CoreDataManager.shared.deleteCategory(category: category)
        }
    }
    
}
