//
//  HomeCollectionViewHeader.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeCollectionViewHeader: UICollectionViewCell {
    
    // user defaults ?
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
        //        CoreDataManager.shared.addLevel(title: "Intermediate")
                
        //        CoreDataManager.shared.addSentence(text: "Word", translation: "Слово", level: levels[0])
        //        CoreDataManager.shared.addSentence(text: "Sentence", translation: "Предложение", level: levels[0])
        
        guard let level = fetchLevel() else { return }
        // Fetch today category
//        let sentences =
        
        let calender = Calendar.current
        guard let uploadDate = level.uploadDate else { return }
        
        if calender.isDateInToday(uploadDate) {
            // Get new sentences
//            let sentences = CoreDataManager.shared.fetchSentences(level: level)
            // Mark isLearned
            // Delete sentences
            // Add new sentences
        }
        
//        cardsDeskView.sentences = sentences
    }
    
    fileprivate func fetchLevel() -> Level? {
        let levels = CoreDataManager.shared.fetchLevels()
        var level: Level?
        
        levels.forEach { (lvl) in
            if lvl.title == levelTitle {
                level = lvl
            }
        }
        return level
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
