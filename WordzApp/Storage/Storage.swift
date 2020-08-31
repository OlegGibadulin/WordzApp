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
        CategoryStorage(title: todayCardsTitle, firstColor: #colorLiteral(red: 0.3058823529, green: 0.631372549, blue: 0.9725490196, alpha: 1), secondColor: #colorLiteral(red: 0.6908428073, green: 0.9608913064, blue: 0.7938471437, alpha: 1)),
        CategoryStorage(title: favouritesTitle, firstColor: #colorLiteral(red: 0.8901960784, green: 0.6274509804, blue: 0.2470588235, alpha: 1), secondColor: #colorLiteral(red: 0.9026226401, green: 0.8602350354, blue: 0.4391778111, alpha: 1)),
        CategoryStorage(title: "Архитектура", firstColor: #colorLiteral(red: 0.9215686275, green: 0.3725490196, blue: 0.2431372549, alpha: 1), secondColor: #colorLiteral(red: 0.8901960784, green: 0.6078431373, blue: 0.2392156863, alpha: 1), sentences: Architecture),
        CategoryStorage(title: "Эмоции", firstColor: #colorLiteral(red: 0.7803921569, green: 0.2156862745, blue: 0.9647058824, alpha: 1), secondColor: #colorLiteral(red: 0.5490196078, green: 0.2274509804, blue: 0.8980392157, alpha: 1), sentences: Emotion),
        CategoryStorage(title: "Дом", firstColor: #colorLiteral(red: 0.9333333333, green: 0.5254901961, blue: 0.4078431373, alpha: 1), secondColor: #colorLiteral(red: 0.9490196078, green: 0.7176470588, blue: 0.5176470588, alpha: 1), sentences: House),
        CategoryStorage(title: "Части тела", firstColor: #colorLiteral(red: 0.8880360723, green: 0.9051850438, blue: 0.3957586884, alpha: 1), secondColor: #colorLiteral(red: 0.464773953, green: 0.9658891559, blue: 0.3734448254, alpha: 1), sentences: BodyParts)
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
