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
        setupButtons()
        //setupLayerShadow()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(swipeGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOneTapPan(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(singleTapGesture)
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = 25
//        self.roundCorners([.topLeft, .bottomRight], radius: 25)
        self.clipsToBounds = false
    }
    
    public func setupLayerShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public func setupLabels() {
        textLabel = UILabel(frame: CGRect(x: 0, y: self.initialHeight / 4, width: self.initialWidth, height: self.initialHeight / 2.5))
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.textColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
//        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.allowsDefaultTighteningForTruncation = true
        textLabel.text = self.wordSelfCard.word
        textLabel.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        textLabel.layer.shadowRadius = 17
        textLabel.layer.shadowOpacity = 0.4
        textLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.addSubview(textLabel)
    }
    
    func setupButtons() {
        let swipeLeftButton = UIButton(frame: CGRect(x: 0, y: initialHeight - 75, width: initialWidth / 2, height: 75))
        swipeLeftButton.setTitle("I don't know this word", for: .normal)
        swipeLeftButton.titleLabel?.numberOfLines = 2
        swipeLeftButton.roundCorners([.bottomLeft], radius: 25)
        swipeLeftButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1)
        swipeLeftButton.addTarget(self, action: #selector(swipeInLeftSide(sender:)), for: .touchUpInside)
        self.addSubview(swipeLeftButton)
        let swipeRightButton = UIButton(frame: CGRect(x: initialWidth / 2, y: initialHeight - 75, width: initialWidth / 2, height: 75))
        swipeRightButton.setTitle("I know this word", for: .normal)
        swipeRightButton.titleLabel?.numberOfLines = 2
        swipeRightButton.roundCorners([.bottomRight], radius: 25)
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1), for: .normal)
        swipeRightButton.backgroundColor = .white
        swipeRightButton.addTarget(self, action: #selector(swipeInRightSide(sender:)), for: .touchUpInside)
        self.addSubview(swipeRightButton)
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
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 5, options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                        self.frame = CGRect(x: 800 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
        }, completion: { (_) in
            self.transform = .identity
            self.removeFromSuperview()
        })
    }
    
    @objc func swipeInLeftSide(sender: UIButton) {
        swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
    }
    
    @objc func swipeInRightSide(sender: UIButton) {
        swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
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

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}