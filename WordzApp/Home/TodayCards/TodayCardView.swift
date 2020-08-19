//
//  AlbumCardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 10.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class TodayCardView: UIView {
    
    var sentences: [Sentence]! {
        didSet {
            if let sentence = sentences.first {
                sentenceLabel.text = sentence.text
                
                var translations = ""
                sentence.translation?.forEach({ (translation) in
                     translations += translation + "\n"
                })
                translationLabel.text = translations
                
                (0..<sentences.count).forEach { (_) in
                    let barView = UIView()
                    barView.backgroundColor = barDeselectedColor
                    barView.layer.cornerRadius = 2
                    barView.clipsToBounds = true
                    barsStackView.addArrangedSubview(barView)
                }
                barsStackView.arrangedSubviews.first?.backgroundColor = .white
                
                toFavouritesButton.isSelected = sentence.isFavourite
            }
        }
    }
    
    fileprivate let barsStackView: UIStackView = {
        let bsv = UIStackView()
        bsv.spacing = 4
        bsv.distribution = .fillEqually
        return bsv
    }()
    
    fileprivate let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        sl.textAlignment = .center
        sl.numberOfLines = 3
        sl.minimumScaleFactor = 0.3
        sl.adjustsFontSizeToFitWidth = true
        return sl
    }()
    
    fileprivate let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tl.textAlignment = .center
        tl.numberOfLines = 3
        tl.minimumScaleFactor = 0.3
        tl.adjustsFontSizeToFitWidth = true
        return tl
    }()
    
    fileprivate let toFavouritesButton: UIButton = {
        let tfb = UIButton()
        tfb.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        tfb.setImage(UIImage(named: "star_filled")?.withRenderingMode(.alwaysTemplate), for: .selected)
        tfb.tintColor = .darkBlue
        tfb.translatesAutoresizingMaskIntoConstraints = false
        tfb.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tfb.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tfb.addTarget(self, action: #selector(handleToFavourites), for: .touchUpInside)
        return tfb
    }()
    
    @objc fileprivate func handleToFavourites() {
        guard let sentences = sentences else { return }
        let sentence = sentences[cardInd]
        
        toFavouritesButton.isSelected = !toFavouritesButton.isSelected
        CoreDataManager.shared.favouriteSentence(sentence: sentence)
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
            
            var translations = ""
            sentence.translation?.forEach({ (translation) in
                 translations += translation + "\n"
            })
            translationLabel.text = translations
            
            barsStackView.arrangedSubviews.forEach { (v) in
                v.backgroundColor = barDeselectedColor
            }
            barsStackView.arrangedSubviews[cardInd].backgroundColor = .white
            
            toFavouritesButton.isSelected = sentence.isFavourite
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
        layer.cornerRadius = 23
        clipsToBounds = true
        backgroundColor = .lightBlue
        
        setupBarsStackView()
        
        addSubview(sentenceLabel)
        sentenceLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: bounds.height / 3, left: 16, bottom: 0, right: 16))
        
        addSubview(translationLabel)
        translationLabel.anchor(top: sentenceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        addSubview(toFavouritesButton)
        toFavouritesButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        toFavouritesButton.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 5).isActive = true
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 4))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
