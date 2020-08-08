//
//  Storage.swift
//  WordzApp
//
//  Created by Mac-HOME on 27.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

struct Storage {
    
    static let shared = Storage()
    
    // MARK: - Levels
    
    let levels = [
        LevelStorage(title: "Beginner", localization: "Начинающий"),
        LevelStorage(title: "Intermediate", localization: "Средний"),
        LevelStorage(title: "Advanced", localization: "Продвинутый"),
    ]
    
    // MARK: - Categories
    
    let categories = [
        CategoryStorage(title: "Today", localization: "Сегодня", firstColor: .lightRed, secondColor: .lightGray),
        CategoryStorage(title: "Favourites", localization: "Избранное", firstColor: .lightRed, secondColor: .lightGray),
    ]
    
    // MARK: - Sentences
    
}
