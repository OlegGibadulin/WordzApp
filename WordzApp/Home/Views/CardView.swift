//
//  CardView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CardView: UIView {
    var initialWidth: CGFloat = 0
    var initialHeight: CGFloat = 0
    
    let threshold: CGFloat = 125
    
    var wordLabel: UILabel!
    var translateLabel: UILabel!
    
    var word: Word!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialWidth = frame.width
        self.initialHeight = frame.height
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    public func setupLabels() {
        wordLabel = UILabel(frame: CGRect(x: 0, y: self.initialHeight / 2, width: self.initialWidth, height: 40))
        wordLabel.textColor = .white
        wordLabel.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        wordLabel.textAlignment = .center
        wordLabel.text = self.word.word
        self.addSubview(wordLabel)
        
        translateLabel = UILabel(frame: CGRect(x: 0, y: self.initialHeight / 2 + 40, width: self.initialWidth, height: 35))
        translateLabel.textColor = .white
        translateLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        translateLabel.textAlignment = .center
        translateLabel.text = self.word.translate
        self.addSubview(translateLabel)
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
        let shouldDismissedCard = abs(gesture.translation(in: nil).x) > threshold
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
