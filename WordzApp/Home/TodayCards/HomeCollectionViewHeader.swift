//
//  HomeCollectionViewHeader.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeCollectionViewHeader: UICollectionViewCell {
    
    // TODO: user defaults
    fileprivate let levelTitle = "Beginner"
    
    fileprivate let logoView: UIImageView = {
        let image = UIImage(named: "wordz_black_extended")
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        iv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return iv
    }()
    
    fileprivate lazy var cardsDeskView = TodayCardView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fetchSentences()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let gap = UIView()
        gap.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let overallStackView = UIStackView(arrangedSubviews: [logoView, gap, cardsDeskView])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 8
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    fileprivate func fetchSentences() {
        
//        Storage.deleteCategories()
//        Storage.uploadsCategories()
//
//        let lvl = CoreDataManager.shared.fetchLevel(title: levelTitle)
//        Storage.deleteSentences(level: lvl!)
//
//        Storage.deleteLevels()
//        Storage.uploadLevels()
//
//        guard let level = CoreDataManager.shared.fetchLevel(title: levelTitle) else { return }
//
//        guard let uploadDate = level.uploadDate else { return }
//
//        print(uploadDate)
//
//        Storage.uploadSentences(level: level)
//
//        return

        // Fetch sentences from today category
        guard let todayCategory = CoreDataManager.shared.fetchCategory(title: "Today") else { return }
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