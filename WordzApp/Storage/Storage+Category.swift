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
    let localization: String
    let firstColor: UIColor
    let secondColor: UIColor
}

extension Storage {
    
    func uploadsCategories() {
        categories.forEach { (category) in
            CoreDataManager.shared.addCategory(title: category.title, firstColor: category.firstColor, secondColor: category.secondColor)
        }
    }
    
    func deleteCategories() {
        let categories = CoreDataManager.shared.fetchCategories()
        categories.forEach { (category) in
            CoreDataManager.shared.deleteCategory(category: category)
        }
    }
    
}
