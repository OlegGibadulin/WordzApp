//
//  CardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    static private let threshold: CGFloat = 125
    
    private var initialWidth: CGFloat = 0
    private var initialHeight: CGFloat = 0
    
    private var isOpen = true
    
    private var textLabel: UILabel!
    public var wordSelfCard: Word!
    
    override init(frame: CGRect) {
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
    
    fileprivate func setupLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    public func setupLabels() {
        textLabel = UILabel(frame: CGRect(x: 0, y: self.initialHeight / 2, width: self.initialWidth, height: 40))
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.allowsDefaultTighteningForTruncation = true
        textLabel.text = self.wordSelfCard.word
        self.addSubview(textLabel)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
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
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 4, options: .curveEaseOut, animations: {
                        if shouldDismissedCard {
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
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
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
            textLabel.text = wordSelfCard.translate
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
