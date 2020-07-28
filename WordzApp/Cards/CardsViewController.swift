//
//  CardsViewController.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var category: Category?
    
    fileprivate var sentences = [Sentence]()
    
    var topView: UIView!
    var centerView: UIView!
    var bottomView: UIView!
    
    var cardsView = [CardView]()
    
    let words = [
        Word(word: "develop", translate: "разрабатывать"),
        Word(word: "cat", translate: "кошка"),
        Word(word: "LOL KEK", translate: "собака"),
        Word(word: "book", translate: "книга"),
        Word(word: "Hellow haw rea ewfkjwejk wefjwelkfjwel wefkjlwefjlkew lryou, what u are doing here, i do not know man! Go out", translate: "книгакнигакнигакнигакнига"),
        Word(word: "bookbookbo ejnrkjerngker okbookb ookbook", translate: "книгакнигакнигакнигакнига"),
        Word(word: "Develop", translate: "Разрабатывать")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupLayout()
        setupButtons()
        setupDummyCards()
        
    }
    
    func setupLayout() {
        self.view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9490196078, blue: 0.9137254902, alpha: 1)
    }
    
    func setupDummyCards() {
        let width = self.view.frame.width / 1.15
        //let height = self.view.frame.height / 1.75
        let height = CGFloat(520)
        
        words.forEach { (curWord) in
            let cardView = CardView(frame: CGRect(x: (self.view.frame.width - width) / 2,
                                                  y: self.view.frame.width - height / 2.35,
                                                  width: width,
                                                  height: height))
            cardView.wordSelfCard = curWord
            
            cardView.setupLabels()
            self.cardsView.append(cardView)
            self.view.addSubview(cardView)
        }
        
        cardsView.first?.setupLayerShadow()
    }
    
    
    
    func setupButtons() {
        let settingsButton = UIButton(frame: CGRect(x: 315, y: 65, width: 35, height: 35))
        //        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.setImage(UIImage(named: "threePointsIcon"), for: .normal)
        settingsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        settingsButton.layer.cornerRadius = 8
        settingsButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        settingsButton.layer.shadowRadius = 7
        settingsButton.layer.shadowOpacity = 0.5
        settingsButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(settingsButton)
        
        let backButton = UIButton(frame: CGRect(x: 27, y: 65, width: 35, height: 35))
//        backButton.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        backButton.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)

        backButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        backButton.layer.cornerRadius = 8
        backButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        backButton.layer.shadowRadius = 7
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    fileprivate func fetchSentences() -> [Sentence] {
        let sentences = CoreDataManager.shared.fetchNotLearnedSentences(category: category)
        
        // TODO: user defaults
        let shuffledSentences = sentences[randomPick: 10]
        
        return shuffledSentences
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
}

extension UIView {
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
}

//    fileprivate func setupButtons() {
//        let swipeLeftButton = UIButton(frame: CGRect(x: 15, y: 570, width: 120, height: 70))
//        swipeLeftButton.setTitle("Не знаю", for: .normal)
//        swipeLeftButton.backgroundColor = .lightGray
//        swipeLeftButton.layer.cornerRadius = 10
//        swipeLeftButton.addTarget(self, action: #selector(swipeLeft(sender:)), for: .touchUpInside)
//        self.view.addSubview(swipeLeftButton)
//
//        let swipeRightButton = UIButton(frame: CGRect(x: 240, y: 570, width: 120, height: 70))
//        swipeRightButton.setTitle("Знаю", for: .normal)
//        swipeRightButton.backgroundColor = .lightGray
//        swipeRightButton.layer.cornerRadius = 10
//        swipeRightButton.addTarget(self, action: #selector(swipeRight(sender:)), for: .touchUpInside)
//
//        let rotateCardButton = UIButton(frame: CGRect(x: 147, y: 570, width: 80, height: 70))
//        rotateCardButton.setTitle("Перевод", for: .normal)
//        rotateCardButton.backgroundColor = .lightGray
//        rotateCardButton.layer.cornerRadius = 10
//        rotateCardButton.addTarget(self, action: #selector(rotateCard(sender:)), for: .touchUpInside)
//
//        self.view.addSubview(swipeLeftButton)
//        self.view.addSubview(swipeRightButton)
//        self.view.addSubview(rotateCardButton)
//    }
//
//    @objc func swipeLeft(sender: UIButton) {
//        let card = cardsView.popLast()
//        card?.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
//    }
//
//    @objc func swipeRight(sender: UIButton) {
//        let card = cardsView.popLast()
//        card?.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
//    }
//
//    @objc func rotateCard(sender: UIButton) {
//        let card = cardsView.last
//        card?.showAnotherTranslation()
//    }
