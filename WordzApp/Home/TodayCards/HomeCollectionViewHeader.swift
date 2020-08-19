//
//  HomeCollectionViewHeader.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeCollectionViewHeader: UICollectionViewCell {
    
    fileprivate let levelTitle: String = {
        let defaults = UserDefaults.standard
        let levelIndex = defaults.integer(forKey: "LevelIndex")
        
        let levels = CoreDataManager.shared.fetchLevels()
        let levelsTitle = levels.compactMap { (level) -> String? in
            return level.title
        }
        return levelsTitle[levelIndex]
    }()
    
    fileprivate lazy var cardsDeskView = TodayCardView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    
    fileprivate let cardsLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "cardz_orange"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fetchTodaySentences()
        setupLayout()
    }
    
    fileprivate lazy var headerView = HeaderView(frame: self.frame)
    
    fileprivate func setupLayout() {
        addSubview(headerView)
        headerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: -90, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 220))
        
        let cardsLogoStackView = UIStackView(arrangedSubviews: [cardsLogoView, UIView()])
        cardsLogoStackView.axis = .horizontal
        cardsLogoStackView.distribution = .fill
        
        let overallStackView = UIStackView(arrangedSubviews: [cardsDeskView, cardsLogoStackView])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 30
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 85, left: 20, bottom: 0, right: 20)
    }
    
    // TODO: - Make it work again
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

        cardsDeskView.sentences = sentences
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
