//
//  AlbumCardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 10.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class AlbumCardView: UIView {
    
    var sentences: [Sentence]! {
        didSet {
            if let sentence = sentences.first {
                sentenceLabel.text = sentence.text
                translationLabel.text = sentence.translation
                
                (0..<sentences.count).forEach { (_) in
                    let barView = UIView()
                    barView.backgroundColor = barDeselectedColor
                    barView.layer.cornerRadius = 2
                    barView.clipsToBounds = true
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
    
    let toFavouritesButton: UIButton = {
        let tfb = UIButton()
        tfb.setImage(UIImage(named: "bookmark_white"), for: .normal)
        tfb.setImage(UIImage(named: "bookmark_black"), for: .selected)
        tfb.addTarget(self, action: #selector(handleToFavourites), for: .touchUpInside)
        return tfb
    }()
    
    @objc fileprivate func handleToFavourites() {
        if toFavouritesButton.isSelected {
            toFavouritesButton.isSelected = false
            // delete from Favourites
        } else {
            toFavouritesButton.isSelected = true
            // save to Favourites
        }
    }
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    var cardInd = 0 {
        didSet {
            let sentence = sentences[cardInd]
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
            cardInd = (cardInd + 1) % sentences.count
        } else {
            if cardInd == 0 {
                cardInd = sentences.count - 1
            } else {
                cardInd -= 1
            }
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
        
        addSubview(toFavouritesButton)
        toFavouritesButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 4))
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
