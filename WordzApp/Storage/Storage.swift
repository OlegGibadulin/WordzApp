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
        LevelStorage(title: "Средний", sentences: nil),
        LevelStorage(title: "Продвинутый", sentences: nil),
    ]
    
    // MARK: - Categories
    
    let todayCardsTitle = "Сегодня"
    let favouritesTitle = "Избранное"
    
    lazy var categories: [CategoryStorage] = [
        CategoryStorage(title: todayCardsTitle, firstColor: .lightRed, secondColor: .lightGray, sentences: nil),
        CategoryStorage(title: favouritesTitle, firstColor: .lightRed, secondColor: .lightGray, sentences: nil),
        CategoryStorage(title: "Архитектура", firstColor: .lightRed, secondColor: .cyan, sentences: Architecture),
    ]
    
    // MARK: - Sentences
    
}
