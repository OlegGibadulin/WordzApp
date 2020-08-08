//
//  CardsViewController.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

protocol CardSwipe: class {
    func updateSwipedCard(isFamilarWordSwiped: Bool)
}

protocol CardReturnBack: class {
    func returnBack()
}

final class CardsViewController: UIViewController, CardSwipe, CardReturnBack {
    
    var category: Category?
    
    fileprivate var sentences = [Sentence]()

    var tmp1StackView: UIStackView!
    var cardContentStackView: UIStackView!
    var cardButtonsStackView: UIStackView!
    var cardsStackView: UIStackView!
    var tmp2StackView: UIStackView!
    var overallStackView: UIStackView!
    
    var circle1 : UIView!
    
    private var result = (unfamilarWords: 0, familarWords: 0)
    
    var cardsView = [CardView]()
    var oneCardView: CardResultView!
    
    var words = [
        Word(word: "develop", translate: "разрабатывать"),
        Word(word: "imagine", translate: "воображать"),
        Word(word: "confirmation", translate: "подтверждение"),
        Word(word: "to go away", translate: "уходить"),
        Word(word: "calling", translate: "зовущий")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupLayout()
        setupNavigationBar()
        setupDesign()
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
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 33))
        settingsButton.setImage(UIImage(named: "threePointsIcon"), for: .normal)
        settingsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        settingsButton.layer.cornerRadius = 8
        settingsButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        settingsButton.layer.shadowRadius = 3
        settingsButton.layer.shadowOpacity = 0.5
        settingsButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        backButton.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        backButton.layer.cornerRadius = 8
        backButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        backButton.layer.shadowRadius = 3
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func fillCards() {
        let frame = cardContentStackView.frame
        let repeats = 3
        
        oneCardView = CardResultView(frame: frame, view: self)
        cardContentStackView.addSubview(oneCardView)
        oneCardView.finishButton.isEnabled = false
        
        var allWords = [Word]()
        
        for _ in 0..<repeats {
            allWords += words
        }
        
        for _ in 0..<repeats {
            for i in 1..<allWords.count-1 {
                var k = 0
                while (k < 3) {
                    let number1 = Int.random(in: 1..<allWords.count-1)
                    if (allWords[i].word != allWords[number1-1].word && allWords[i].word != allWords[number1+1].word) {
                        let tmp = allWords[number1]
                        allWords[number1] = allWords[i]
                        allWords[i] = tmp
                    }
                    
                    k += 1
                }
            }
        }
        
        allWords.forEach { (word) in
            let cardView = CardView(frame: frame, word: word, view: self)
            cardView.setupLabels()
            cardView.isHidden = true
            self.cardsView.append(cardView)
            cardView.isUserInteractionEnabled = false
            cardContentStackView.addSubview(cardView)
        }
        
        if cardsView.count > 2 {
            cardsView[cardsView.count - 1].isHidden = false
            cardsView[cardsView.count - 2].isHidden = false
//            cardsView[cardsView.count - 3].isHidden = false
            cardsView.last?.isUserInteractionEnabled = true
        }
    }
    
    func setupDummyCards() {
        let tmpCardResultView = CardResultView()
        tmpCardResultView.fillSuperview()
        
        tmpCardResultView.translatesAutoresizingMaskIntoConstraints = false
        cardContentStackView = UIStackView(arrangedSubviews: [tmpCardResultView])
        cardContentStackView.axis = .vertical
    }
    
    func setupMoveCardButtons() {
        let swipeLeftButton = UIButton()
        swipeLeftButton.roundCorners([.layerMinXMaxYCorner], radius: 23)
        swipeLeftButton.setTitle("I don't know\nthis word", for: .normal)
        swipeLeftButton.titleLabel?.numberOfLines = 2
        swipeLeftButton.setTitleColor(#colorLiteral(red: 0.006038194057, green: 0.06411762536, blue: 0.6732754707, alpha: 1), for: .highlighted)
        swipeLeftButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1)
        swipeLeftButton.addTarget(self, action: #selector(swipeLeft), for: .touchUpInside)
        swipeLeftButton.clipsToBounds = false
        swipeLeftButton.translatesAutoresizingMaskIntoConstraints = false
        swipeLeftButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        swipeLeftButton.layer.shadowRadius = 5
        swipeLeftButton.layer.shadowOpacity = 0.2
        swipeLeftButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let swipeRightButton = UIButton()
        swipeRightButton.roundCorners([.layerMaxXMaxYCorner], radius: 23)
        swipeRightButton.setTitle("I know\nthis word", for: .normal)
        swipeRightButton.titleLabel?.numberOfLines = 2
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1), for: .normal)
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1), for: .highlighted)
        swipeRightButton.backgroundColor = .white
        swipeRightButton.addTarget(self, action: #selector(swipeRight), for: .touchUpInside)
        swipeRightButton.clipsToBounds = false
        swipeRightButton.translatesAutoresizingMaskIntoConstraints = false
        swipeRightButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        swipeRightButton.layer.shadowRadius = 5
        swipeRightButton.layer.shadowOpacity = 0.2
        swipeRightButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
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
        
        overallStackView = UIStackView(arrangedSubviews: [tmp1StackView, cardsStackView, tmp2StackView])
        overallStackView.spacing = 0
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        
        self.view.addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    func setupAnchors() {
        tmp1StackView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        cardContentStackView.heightAnchor.constraint(equalToConstant: 460).isActive = true
        cardButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardButtonsStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        if cardButtonsStackView.arrangedSubviews.count > 1 {
            cardButtonsStackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: cardButtonsStackView.arrangedSubviews[0].widthAnchor, multiplier: 1).isActive = true
        }
        
        tmp2StackView.heightAnchor.constraint(equalTo: tmp1StackView.heightAnchor, multiplier: 1.35).isActive = true
        
        cardsStackView.bringSubviewToFront(cardContentStackView)
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
    
    public func returnBack() {
        circle1.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func backButtonTapped(sender: UIButton) {
        returnBack()
    }
    
    func setupDesign() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let circle1Height = CGFloat(height / 2.5)
        
        self.circle1 = UIView(frame: CGRect(x: (-1 ) * circle1Height / 1.8, y: height * (1/5), width: circle1Height, height: circle1Height))
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
    
    public func updateSwipedCard(isFamilarWordSwiped: Bool) {
        if isFamilarWordSwiped == true {
            result.familarWords += 1
        } else {
            result.unfamilarWords += 1
        }
        
        if cardsView.count > 0 {
            cardsView[cardsView.count - 1].isHidden = false
        }
        
        if cardsView.count > 1 {
            cardsView[cardsView.count - 2].isHidden = false
        }
        
        if cardsView.count > 2 {
            cardsView[cardsView.count - 3].isHidden = false
        }
        
        cardsView.popLast()
        
        cardsView.last?.isUserInteractionEnabled = true
        
        if cardsView.count < 1 {
            oneCardView.finishButton.isEnabled = true
        }
            
        oneCardView.updateLabel(message: result)
    }
    
    @objc internal func swipeLeft() {
        if let card = cardsView.last {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
            updateSwipedCard(isFamilarWordSwiped: false)
        }
    }
    
    @objc internal func swipeRight() {
        if let card = cardsView.last {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
            updateSwipedCard(isFamilarWordSwiped: true)
        }
    }
}
