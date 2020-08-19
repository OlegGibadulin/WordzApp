//
//  Storage.swift
//  WordzApp
//
//  Created by Mac-HOME on 27.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

struct Storage {
    
    static var shared = Storage()
    
    // MARK: - Levels
    
    let levels = [
        LevelStorage(title: "Начинающий", sentences: Architecture),
        LevelStorage(title: "Средний", sentences: Architecture),
        LevelStorage(title: "Продвинутый", sentences: Architecture),
    ]
    
    // MARK: - Categories
    
    let todayCardsTitle = "Сегодня"
    let favouritesTitle = "Избранное"
    
    lazy var categories: [CategoryStorage] = [
        CategoryStorage(title: todayCardsTitle, firstColor: .lightRed, secondColor: .lightGray),
        CategoryStorage(title: favouritesTitle, firstColor: .lightRed, secondColor: .lightGray),
        CategoryStorage(title: "Архитектура", firstColor: .lightRed, secondColor: .cyan, sentences: Architecture),
    ]
    
    let levelsTitle = [
        "Начинающий": "TodayBegginer",
        "Средний": "TodayIntermediate",
        "Продвинутый": "TodayAdvanced",
    ]
    
    lazy var categoriesForLevels: [CategoryStorage] = self.levels.map { (level) -> CategoryStorage in
        return CategoryStorage(title: levelsTitle[level.title]!, isHidden: true)
    }
    
}
