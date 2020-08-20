//
//  CardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

final class CardView: UIView {
    static private let threshold: CGFloat = 100
    
    private var initialWidth: CGFloat = 0
    private var initialHeight: CGFloat = 0
    private var isOpen = true
    private var textLabel: UILabel!
    private var wordSelfCard: Word!
    private var view: CardInteractionController!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialWidth = frame.width
        self.initialHeight = frame.height
        
        setupLayout()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(swipeGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOneTapPan(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(singleTapGesture)
    }
    
    required convenience init(frame: CGRect, word: Word, view: CardInteractionController) {
        self.init(frame: frame)
        
        self.wordSelfCard = word
        self.view = view
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        self.layer.cornerRadius = 23
        self.clipsToBounds = false
    }
    
    public func setupLayerShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public func setupLabels() {
        textLabel = UILabel(frame: CGRect(x: 10, y: self.initialHeight / 3.5, width: self.initialWidth - 20, height: self.initialHeight / 2.5))
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 5
        textLabel.textColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.allowsDefaultTighteningForTruncation = true
        
        if wordSelfCard != nil {
            textLabel.text = self.wordSelfCard.word
        }
        
        textLabel.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        textLabel.layer.shadowRadius = 17
        textLabel.layer.shadowOpacity = 0.4
        textLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.addSubview(textLabel)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            view.enableSwipeButtons(isEnabled: false)
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
            view.enableSwipeButtons(isEnabled: true)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 15
        let angle = degrees * .pi / 180
        
        let rotationTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1: -1
        let shouldDismissedCard = abs(gesture.translation(in: nil).x) > CardView.threshold
        
        UIView.animate(withDuration: 0.4, delay: 0.01, usingSpringWithDamping: 10,
                       initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                        if shouldDismissedCard {
                            
                            if (self.view != nil && translationDirection > 0) {
                                self.view.updateSwipedCard(isFamilarWordSwiped: true)
                            } else if (self.view != nil && translationDirection <= 0) {
                                self.view.updateSwipedCard(isFamilarWordSwiped: false)
                            }
                            self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
                        } else {
                            self.transform = .identity
                        }
        }, completion: { (_) in
            self.transform = .identity
            if shouldDismissedCard {
                self.removeFromSuperview()
            }
        })
    }
    
    public func swipeCard(IfPositiveNumberThenSwipeRightElseLeft translationDirection: CGFloat) {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                        self.frame = CGRect(x: 800 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
        }, completion: { (_) in
            self.transform = .identity
            self.removeFromSuperview()
        })
    }
    
    @objc fileprivate func handleOneTapPan(gesture: UIPanGestureRecognizer) {
        showAnotherTranslation()
    }
    
    public func showAnotherTranslation() {
        if isOpen {
            isOpen = false
            
            textLabel.text = wordSelfCard.toStringTranslate
//            textLabel.text = wordSelfCard.translate
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        } else {
            isOpen = true
            textLabel.text = wordSelfCard.word
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
