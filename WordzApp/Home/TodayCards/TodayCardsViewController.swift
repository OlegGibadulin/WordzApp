//
//  TodayCardsViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 18.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class TodayCardsViewController: UIViewController {
    
    fileprivate let levelTitle: String = {
        let defaults = UserDefaults.standard
        let levelIndex = defaults.integer(forKey: "LevelIndex")
        
        let levels = CoreDataManager.shared.fetchLevels()
        let levelsTitle = levels.compactMap { (level) -> String? in
            return level.title
        }
        return levelsTitle[levelIndex]
    }()

    override func loadView() {
        self.view = TodayCardView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .todayCardHeight))
    }
    
    func view() -> TodayCardView {
        return self.view as! TodayCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodaySentences()
    }
    
    fileprivate func fetchTodaySentences() {
        // Fetch sentences from today category
        guard let todayCategory = CoreDataManager.shared.fetchCategory(title: Storage.shared.todayCardsTitle) else { return }
        var sentences = CoreDataManager.shared.fetchSentences(category: todayCategory)

        // Fetch latest upload date of current level
        guard let level = CoreDataManager.shared.fetchLevel(title: levelTitle) else { return }
        guard let uploadDate = level.uploadDate else { return }

        // Check for need to update
        if !Calendar.current.isDateInToday(uploadDate) {

            // Update upload date
            CoreDataManager.shared.updateDate(level: level)

            // Delete sentences from today category
            sentences.forEach { (sentence) in
                CoreDataManager.shared.deleteSentence(sentence: sentence)
            }

            // Get new set of sentences
            let newSentences = CoreDataManager.shared.fetchNotLearnedSentences(level: level)[randomPick: 10]

            // Add new sentences to today category
            newSentences.forEach { (sentence) in
                guard let text = sentence.text, let translation = sentence.translation else { return }

                CoreDataManager.shared.addSentence(text: text, translation: translation, category: todayCategory)

                // Mark them isLearned
                CoreDataManager.shared.learnSentence(sentence: sentence)
            }

            sentences = newSentences
        }

        view().sentences = sentences
    }

}
