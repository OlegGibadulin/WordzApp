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
        CategoryStorage(title: todayCardsTitle, firstColor: #colorLiteral(red: 0.3058823529, green: 0.631372549, blue: 0.9725490196, alpha: 1), secondColor: #colorLiteral(red: 0.7137254902, green: 0.9882352941, blue: 0.8156862745, alpha: 1)),
        CategoryStorage(title: favouritesTitle, firstColor: #colorLiteral(red: 0.8901960784, green: 0.6274509804, blue: 0.2470588235, alpha: 1), secondColor: #colorLiteral(red: 0.9176470588, green: 0.8705882353, blue: 0.4431372549, alpha: 1)),
        CategoryStorage(title: "Архитектура", firstColor: #colorLiteral(red: 0.9215686275, green: 0.3725490196, blue: 0.2431372549, alpha: 1), secondColor: #colorLiteral(red: 0.8901960784, green: 0.6078431373, blue: 0.2392156863, alpha: 1), sentences: Architecture),
        CategoryStorage(title: "Дом", firstColor: #colorLiteral(red: 0.9333333333, green: 0.5254901961, blue: 0.4078431373, alpha: 1), secondColor: #colorLiteral(red: 0.9490196078, green: 0.7176470588, blue: 0.5176470588, alpha: 1), sentences: House),
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
