//
//  AlbumCardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 10.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class AlbumCardView: UIView {
    
    var album: TodayAlbum! {
        didSet {
            if let sentence = album.sentences.first {
                sentenceLabel.text = sentence.text
                translationLabel.text = sentence.translation
                
                (0..<album.sentences.count).forEach { (_) in
                    let barView = UIView()
                    barView.backgroundColor = barDeselectedColor
                    barsStackView.addArrangedSubview(barView)
                }
                barsStackView.arrangedSubviews.first?.backgroundColor = .white
            }
        }
    }
    
    let barsStackView: UIStackView = {
        let bsv = UIStackView()
        bsv.spacing = 4
        bsv.distribution = .fillEqually
        return bsv
    }()
    
    let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        sl.textAlignment = .center
        sl.numberOfLines = 0
        return sl
    }()
    
    let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tl.textAlignment = .center
        tl.numberOfLines = 0
        return tl
    }()
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    var cardInd = 0 {
        didSet {
            let sentence = album.sentences[cardInd]
            sentenceLabel.text = sentence.text
            translationLabel.text = sentence.translation
            
            barsStackView.arrangedSubviews.forEach { (v) in
                v.backgroundColor = barDeselectedColor
            }
            barsStackView.arrangedSubviews[cardInd].backgroundColor = .white
        }
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldGoToNextCard = tapLocation.x > frame.width / 2 ? true : false
        if shouldGoToNextCard {
            cardInd = min(cardInd + 1, album.sentences.count - 1)
        } else {
            cardInd = max(cardInd - 1, 0)
        }
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .brown
        
        setupBarsStackView()
        
        let topPadding = bounds.height / 3
        addSubview(sentenceLabel)
        sentenceLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: topPadding, left: 16, bottom: 0, right: 16))
        
        addSubview(translationLabel)
        translationLabel.anchor(top: sentenceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
