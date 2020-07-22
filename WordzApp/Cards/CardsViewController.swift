//
//  CardsViewController.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
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
        Word(word: "Hellow haw rea lryou, what u are doing here, i do not know man! Go out", translate: "книгакнигакнигакнигакнига")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupDummyCards()
        setupButtons()
    }
    
    fileprivate func setupButtons() {
        let swipeLeftButton = UIButton(frame: CGRect(x: 15, y: 570, width: 120, height: 70))
        swipeLeftButton.setTitle("Не знаю", for: .normal)
        swipeLeftButton.backgroundColor = .lightGray
        swipeLeftButton.layer.cornerRadius = 10
        swipeLeftButton.addTarget(self, action: #selector(swipeLeft(sender:)), for: .touchUpInside)
        self.view.addSubview(swipeLeftButton)
        
        let swipeRightButton = UIButton(frame: CGRect(x: 240, y: 570, width: 120, height: 70))
        swipeRightButton.setTitle("Знаю", for: .normal)
        swipeRightButton.backgroundColor = .lightGray
        swipeRightButton.layer.cornerRadius = 10
        swipeRightButton.addTarget(self, action: #selector(swipeRight(sender:)), for: .touchUpInside)
        
        let rotateCardButton = UIButton(frame: CGRect(x: 147, y: 570, width: 80, height: 70))
        rotateCardButton.setTitle("Перевод", for: .normal)
        rotateCardButton.backgroundColor = .lightGray
        rotateCardButton.layer.cornerRadius = 10
        rotateCardButton.addTarget(self, action: #selector(rotateCard(sender:)), for: .touchUpInside)
        
        self.view.addSubview(swipeLeftButton)
        self.view.addSubview(swipeRightButton)
        self.view.addSubview(rotateCardButton)
    }
    
    @objc func swipeLeft(sender: UIButton) {
        let card = cardsView.popLast()
        card?.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
    }
    
    @objc func swipeRight(sender: UIButton) {
        let card = cardsView.popLast()
        card?.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
    }
    
    @objc func rotateCard(sender: UIButton) {
        let card = cardsView.last
        card?.showAnotherTranslation()
    }
    
    func setupLayout() {
        topView = UIView()
        topView.backgroundColor = .red
        topView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        centerView = CardView(frame: .zero)
        
        bottomView = UIView()
        bottomView.backgroundColor = .yellow
        bottomView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let overallStackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        //overallStackView.bringSubviewToFront(centerView)
    }
    
    func setupDummyCards() {
        let width = self.view.frame.width / 1.15
        let height = self.view.frame.height / 1.75
        
        words.forEach { (curWord) in
            let cardView = CardView(frame: CGRect(x: (self.view.frame.width - width) / 2,
                                                  y: self.view.frame.width - height / 1.5,
            width: width,
            height: height))
            cardView.wordSelfCard = curWord
            cardView.setupLabels()
            self.cardsView.append(cardView)
            self.view.addSubview(cardView)
        }
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
