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
    
    let words = [
        Word(word: "develop", translate: "разрабатывать"),
        Word(word: "cat", translate: "кошка"),
        Word(word: "dog", translate: "собака"),
        Word(word: "book", translate: "книга"),
        Word(word: "bookbookbo okbookb ookbook", translate: "книгакнигакнигакнигакнига")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupDummyCards()
//        setupLayout()
//        setupDummyCards()
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
        
        overallStackView.bringSubviewToFront(centerView)
    }
    
    func setupDummyCards() {
        let width = self.view.frame.width / 1.1
        let height = self.view.frame.height / 1.75
        
        words.forEach { (curWord) in
            let cardView = CardView(frame: CGRect(x: (self.view.frame.width - width) / 2,
            y: self.view.frame.width - height / 2,
            width: width,
            height: height))
            cardView.word = curWord
            cardView.setupLabels()
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
