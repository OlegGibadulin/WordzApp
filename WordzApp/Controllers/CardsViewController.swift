//
//  CardsViewController.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

protocol CardSwipe {
    func swipeLeft()
    func swipeRight()
}

class CardsViewController: UIViewController, CardSwipe {
    var topButtonStackView: UIStackView!
    var tmp1StackView: UIStackView!
    var cardContentStackView: UIStackView!
    var cardButtonsStackView: UIStackView!
    var cardsStackView: UIStackView!
    var tmp2StackView: UIStackView!
    var overallStackView: UIStackView!
    
    private var result = (unfamilarWords: 0, familarWords: 0)
    
    var cardsView = [CardView]()
    var oneCardView: CardResultView!
    
    let words = [
        Word(word: "develop", translate: "разрабатывать"),
        Word(word: "imagine", translate: "воображать"),
        Word(word: "confirmation", translate: "подтверждение"),
        Word(word: "callingbreakersatisbaker", translate: "вывести"),
        Word(word: "to go away", translate: "уходить"),
        Word(word: "calling", translate: "зовущий")
    ]
    
//    let words: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupLayout()
        setupDesign()
        setupSettingsButtons()
        setupMoveCardButtons()
        setupDummyCards()
        
        setupOverallStackView()
        setupAnchors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fillCards()
    }
    
    func setupLayout() {
        self.view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9490196078, blue: 0.9137254902, alpha: 1)
    }
    
    func fillCards() {
        let frame = cardContentStackView.frame
        
        oneCardView = CardResultView(frame: frame)
//        oneCardView.setupLabel()
        cardContentStackView.addSubview(oneCardView)
        
        words.forEach { (curWord) in
            let cardView = CardView(frame: frame)
            cardView.wordSelfCard = curWord
            
            cardView.view = self
            cardView.setupLabels()
            self.cardsView.append(cardView)
            cardContentStackView.addSubview(cardView)
        }
    }
    
    
    func setupDummyCards() {
        let tmpCardResultView = CardResultView()
        tmpCardResultView.fillSuperview()
        
        tmpCardResultView.translatesAutoresizingMaskIntoConstraints = false
        cardContentStackView = UIStackView(arrangedSubviews: [tmpCardResultView])
        cardContentStackView.axis = .vertical
    }
    
    func setupSettingsButtons() {
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "threePointsIcon"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        settingsButton.layer.cornerRadius = 8
        settingsButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        settingsButton.layer.shadowRadius = 7
        settingsButton.layer.shadowOpacity = 0.5
        settingsButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        backButton.layer.cornerRadius = 8
        backButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        backButton.layer.shadowRadius = 7
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        
        topButtonStackView = UIStackView(arrangedSubviews: [backButton, settingsButton])
        topButtonStackView.axis = .horizontal
        topButtonStackView.distribution = .equalCentering
        topButtonStackView.spacing = 0
    }
    
    func setupMoveCardButtons() {
        let swipeLeftButton = UIButton()
        swipeLeftButton.roundCorners([.layerMinXMaxYCorner], radius: 23)
        swipeLeftButton.setTitle("I don't know\nthis word", for: .normal)
        swipeLeftButton.titleLabel?.numberOfLines = 2
        swipeLeftButton.setTitleColor(#colorLiteral(red: 0.006038194057, green: 0.06411762536, blue: 0.6732754707, alpha: 1), for: .highlighted)
        swipeLeftButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1)
        swipeLeftButton.addTarget(self, action: #selector(swipeLeft), for: .touchUpInside)
        swipeLeftButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        swipeLeftButton.layer.shadowRadius = 5
        swipeLeftButton.layer.shadowOpacity = 0.25
        swipeLeftButton.layer.shadowOffset = CGSize(width: 4, height: 0)
        swipeLeftButton.layer.masksToBounds = false
        
        let swipeRightButton = UIButton()
        swipeRightButton.roundCorners([.layerMaxXMaxYCorner], radius: 23)
        swipeRightButton.setTitle("I know\nthis word", for: .normal)
        swipeRightButton.titleLabel?.numberOfLines = 2
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1), for: .normal)
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1), for: .highlighted)
        swipeRightButton.backgroundColor = .white
        swipeRightButton.addTarget(self, action: #selector(swipeRight), for: .touchUpInside)
        swipeRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        cardButtonsStackView = UIStackView(arrangedSubviews: [swipeLeftButton, swipeRightButton])
        cardButtonsStackView.axis = .horizontal
        cardButtonsStackView.distribution = .fillProportionally
        cardButtonsStackView.spacing = 0
    }
    
    func setupOverallStackView() {
        tmp1StackView = UIStackView(arrangedSubviews: [UIView()])
        tmp2StackView = UIStackView(arrangedSubviews: [UIView()])
        
        cardsStackView = UIStackView(arrangedSubviews: [cardContentStackView, cardButtonsStackView])
        cardsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardsStackView.axis = .vertical
        
        overallStackView = UIStackView(arrangedSubviews: [topButtonStackView, tmp1StackView, cardsStackView, tmp2StackView])
        overallStackView.spacing = 0
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        
        self.view.addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    func setupAnchors() {
        topButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        topButtonStackView.arrangedSubviews.forEach { (view) in
            view.widthAnchor.constraint(equalToConstant: 35).isActive = true
        }
        
        topButtonStackView.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -20).isActive = true
        topButtonStackView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        topButtonStackView.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 20).isActive = true
        topButtonStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        cardContentStackView.heightAnchor.constraint(equalToConstant: 460).isActive = true
        cardButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardButtonsStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        if cardButtonsStackView.arrangedSubviews.count > 1 {
            cardButtonsStackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: cardButtonsStackView.arrangedSubviews[0].widthAnchor, multiplier: 1).isActive = true
        }
        
        tmp2StackView.heightAnchor.constraint(equalTo: tmp1StackView.heightAnchor, multiplier: 1.25).isActive = true
        
        cardsStackView.bringSubviewToFront(cardContentStackView)
    }
    
    var transparentView = UIView()
    var tableView = CardsConfigurationView()
    let screenSize = UIScreen.main.bounds.size
    let heightTable: CGFloat = 250
    
    @objc
    private func settingsButtonTapped(sender: UIButton) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        transparentView.alpha = 0
        tableView.backgroundColor = .white
        window?.addSubview(transparentView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnTranspaerntView))
        transparentView.addGestureRecognizer(tapGesture)
        
        tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: heightTable)
        window?.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: 0, y: self.screenSize.height - self.heightTable, width: self.screenSize.width, height: self.heightTable)
        }, completion: nil)
    }
    
    @objc
    func tapOnTranspaerntView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.heightTable)
        }, completion: nil)
    }
    
    @objc
    private func backButtonTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupDesign() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let circle1Height = CGFloat(height / 2.5)
        
        let circle1 = UIView(frame: CGRect(x: (-1 ) * circle1Height / 1.8, y: height * (1/5), width: circle1Height, height: circle1Height))
        circle1.layer.cornerRadius = circle1Height / 2
        circle1.clipsToBounds = true
        circle1.backgroundColor = #colorLiteral(red: 0, green: 0.08235294118, blue: 1, alpha: 1)
        
        let circle2Height = CGFloat(height / 3.5)
        
        let circle2 = UIView(frame: CGRect(x: width * 0.552, y: (-1) * circle2Height / 5, width: circle2Height, height: circle2Height))
        circle2.layer.cornerRadius = circle2Height / 2
        circle2.clipsToBounds = true
        circle2.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.7607843137, alpha: 1)
        
        let circle3Height = CGFloat(height / 2.9)
        
        let circle3 = UIView(frame: CGRect(x: width * (2.5 / 3.5), y: height * (0.4), width: circle3Height, height: circle3Height))
        circle3.layer.cornerRadius = circle3Height / 2
        circle3.clipsToBounds = true
        circle3.backgroundColor = #colorLiteral(red: 0, green: 0.8196078431, blue: 1, alpha: 1)
        
        self.view.addSubview(circle1)
        self.view.addSubview(circle2)
        self.view.addSubview(circle3)
    }
    
    @objc func swipeLeft() {
        if let card = cardsView.popLast() {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
            result.unfamilarWords += 1
            oneCardView.updateLabel(message: result)
        }
    }
    
    @objc func swipeRight() {
        if let card = cardsView.popLast() {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
            result.familarWords += 1
            oneCardView.updateLabel(message: result)
        }
    }
}
