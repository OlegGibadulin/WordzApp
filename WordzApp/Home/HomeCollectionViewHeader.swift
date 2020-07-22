//
//  HomeCollectionViewHeader.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
//import RealmSwift

//private var sentences: Results<Sentence>!

private let sentences = [
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово")
]

//private let todayAlbum = TodayAlbum(sentences: sentences)

class HomeCollectionViewHeader: UICollectionViewCell {
    
    let logoView: UIImageView = {
        let image = UIImage(named: "wordz_black_extended")
        let iv = UIImageView(image: image)
        iv.contentMode = .left
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return iv
    }()
    
    let profileView: UserProfileView = {
        let pv = UserProfileView()
        pv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return pv
    }()
    
    let cardsDeskView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCards()
    }
    
    fileprivate func setupCards() {
        let albumCardView = AlbumCardView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        cardsDeskView.addSubview(albumCardView)
        albumCardView.fillSuperView()
        
        albumCardView.sentences = sentences
    }
    
    fileprivate func setupLayout() {
//        let overallStackView = UIStackView(arrangedSubviews: [logoView, profileView, cardDeskView])
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
