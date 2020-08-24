//
//  CardsConfigurationView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 17.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

final class CardsSettingsView: UIView {
    
    // MARK:- Line 1 variables
    fileprivate var firstLineStackView: UIStackView!
    fileprivate let сardsInPackLabel : UILabel = {
        let cinp = UILabel()
        cinp.textColor = .black
        cinp.text = "Слов в стопке: "
        cinp.textAlignment = .left
        cinp.textColor = UIColor.appColor(.text_black_white)
        return cinp
    }()
    
    fileprivate var countCardsLabel : UILabel = {
        let countCardsLabel = UILabel()
        let count = CardsSettings.сardsInPack as Int
        countCardsLabel.text = String(count)
        countCardsLabel.textColor = UIColor.appColor(.text_black_white)
        countCardsLabel.textAlignment = .center
        return countCardsLabel
    }()
    
    fileprivate var plusCardsCountButton: UIButton = {
        let plusCardsCountButton = UIButton()
        guard let plusImage = UIImage(named: "plusIcon") else { return UIButton() }
        plusCardsCountButton.setImage(plusImage, for: .normal)
        plusCardsCountButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        plusCardsCountButton.layer.cornerRadius = 8
        return plusCardsCountButton
    }()
    
    fileprivate var minusCardsCountButton: UIButton = {
        let minusCardsCountButton = UIButton()
        guard let minusImage = UIImage(named: "minusIcon") else { return UIButton() }
        minusCardsCountButton.setImage(minusImage, for: .normal)
        minusCardsCountButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        minusCardsCountButton.layer.cornerRadius = 8
        return minusCardsCountButton
    }()
    
    // MARK:- Line 2 variables
    fileprivate var secondLineStackView: UIStackView!
    fileprivate var сardsRepeatsLabel : UILabel = {
        let сardsRepeatsLabel = UILabel()
        сardsRepeatsLabel.textColor = UIColor.appColor(.text_black_white)
        сardsRepeatsLabel.text = "Повторов каждого слова: "
        сardsRepeatsLabel.textAlignment = .left
        return сardsRepeatsLabel
    }()
    
    fileprivate var countRepeatsLabel : UILabel = {
        let countRepeatsLabel = UILabel()
        let count = CardsSettings.сardsRepeats as Int
        countRepeatsLabel.textColor = UIColor.appColor(.text_black_white)
        countRepeatsLabel.text = String(count)
        countRepeatsLabel.textAlignment = .center
        return countRepeatsLabel
    }()
    
    fileprivate var plusCardsRepeatsButton: UIButton! = {
        let plusCardsRepeatsButton = UIButton()
        guard let plusImage = UIImage(named: "plusIcon") else { return UIButton() }
        plusCardsRepeatsButton.setImage(plusImage, for: .normal)
        plusCardsRepeatsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        plusCardsRepeatsButton.layer.cornerRadius = 8
        return plusCardsRepeatsButton
    }()
    
    fileprivate var minusCardsRepeatsButton: UIButton = {
        let minusCardsRepeatsButton = UIButton()
        guard let minusImage = UIImage(named: "minusIcon") else { return UIButton() }
        minusCardsRepeatsButton.setImage(minusImage, for: .normal)
        minusCardsRepeatsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        minusCardsRepeatsButton.layer.cornerRadius = 8
        return minusCardsRepeatsButton
    }()
    
    // MARK:- Line 3 variable
    fileprivate let discardButton: UIButton = {
        let db: UIButton = UIButton()
        db.setTitle("Сбросить прогресс", for: .normal)
        db.backgroundColor = .clear
        db.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        db.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.4008454623), for: .highlighted)
        db.layer.cornerRadius = 8
        db.contentHorizontalAlignment = .left
        db.titleLabel?.textAlignment = .left
        return db
    }()
    
    fileprivate var thirdLineStackView: UIStackView!
    
    fileprivate var overallStackView: UIStackView!
    
    fileprivate let topBar: UIView = {
        let tb = UIView()
        tb.layer.cornerRadius = 2
        tb.clipsToBounds = true
        tb.backgroundColor = .lightGray
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tb.heightAnchor.constraint(equalToConstant: 4).isActive = true
        return tb
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupLines()
        setupTargetsForButtons()
    }
    
    // MARK:- Setup layout
    fileprivate func setupLayout() {
        self.backgroundColor = UIColor.appColor(.white_lightgray)
//        self.backgroundColor = .white
        self.layer.cornerRadius = 23
    }
    
    // MARK:- Setup Lines
    fileprivate func setupLines() {
        addSubview(topBar)
        topBar.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        topBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        setupFirstLine()
        setupSecondLine()
        setupThirdLine()
        setupOverallStackview()
        setupAnchors()
    }
    
    fileprivate func setupFirstLine() {
        let view1 = UIView()
        
        firstLineStackView = UIStackView(arrangedSubviews: [сardsInPackLabel, view1, minusCardsCountButton, countCardsLabel, plusCardsCountButton])
        firstLineStackView.axis = .horizontal
        firstLineStackView.distribution = .equalSpacing
        firstLineStackView.spacing = 10
        //widthAnchor.constraint(equalToConstant: frame.width - 100).isActive = true
    }
    
    fileprivate func setupSecondLine() {
        let view1 = UIView()
        
        secondLineStackView = UIStackView(arrangedSubviews: [сardsRepeatsLabel, view1, minusCardsRepeatsButton, countRepeatsLabel, plusCardsRepeatsButton, view1])
        secondLineStackView.axis = .horizontal
        secondLineStackView.distribution = .equalCentering
        secondLineStackView.spacing = 10
    }
    
    fileprivate func setupThirdLine() {
        thirdLineStackView = UIStackView(arrangedSubviews: [discardButton])
        thirdLineStackView.axis = .horizontal
        thirdLineStackView.spacing = 10
    }
    
    fileprivate func setupOverallStackview() {
        let view1 = UIView()
//        view1.backgroundColor = .green
        let view2 = UIView()
//        let view3 = UIView()
//        view2.backgroundColor = .yellow
        
        overallStackView = UIStackView(arrangedSubviews: [firstLineStackView, view1, secondLineStackView, view2, thirdLineStackView])
        overallStackView.spacing = 10
        overallStackView.axis = .vertical
        overallStackView.distribution = .fillProportionally
        
        self.addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 30, left: 20, bottom: 355, right: 15))
    }
    
    fileprivate func setupAnchors() {
        plusCardsCountButton.translatesAutoresizingMaskIntoConstraints = false
        countCardsLabel.translatesAutoresizingMaskIntoConstraints = false
        minusCardsCountButton.translatesAutoresizingMaskIntoConstraints = false
        
        plusCardsCountButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        countCardsLabel.rightAnchor.constraint(equalTo: plusCardsCountButton.leftAnchor, constant: -10).isActive = true
        minusCardsCountButton.rightAnchor.constraint(equalTo: countCardsLabel.leftAnchor, constant: -10).isActive = true
        plusCardsCountButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        plusCardsCountButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        minusCardsCountButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        minusCardsCountButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        сardsInPackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countRepeatsLabel.translatesAutoresizingMaskIntoConstraints = false
        plusCardsRepeatsButton.translatesAutoresizingMaskIntoConstraints = false
        minusCardsRepeatsButton.translatesAutoresizingMaskIntoConstraints = false
        
        plusCardsRepeatsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        countRepeatsLabel.rightAnchor.constraint(equalTo: plusCardsCountButton.leftAnchor, constant: -10).isActive = true
        minusCardsRepeatsButton.rightAnchor.constraint(equalTo: countCardsLabel.leftAnchor, constant: -10).isActive = true
        
        plusCardsRepeatsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        minusCardsRepeatsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        countRepeatsLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        countCardsLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        firstLineStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        secondLineStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLineStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        thirdLineStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdLineStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        thirdLineStackView.topAnchor.constraint(equalTo: secondLineStackView.bottomAnchor, constant: -10)
    }
    
    // MARK:- Setup Targets For Buttons
    fileprivate func setupTargetsForButtons() {
        plusCardsCountButton.addTarget(self, action: #selector(plusCardsCountTapped(sender:)), for: .touchUpInside)
        minusCardsCountButton.addTarget(self, action: #selector(minusCardsCountTapped(sender:)), for: .touchUpInside)
        plusCardsRepeatsButton.addTarget(self, action: #selector(plusCardsRepeatsTapped(sender:)), for: .touchUpInside)
        minusCardsRepeatsButton.addTarget(self, action: #selector(minusCardsRepeatsTapped(sender:)), for: .touchUpInside)
        discardButton.addTarget(self, action: #selector(resetProgress(sender:)), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func plusCardsCountTapped(sender: UIButton) {
        if (CardsSettings.сardsInPack < 25) {
            CardsSettings.сardsInPack += 5
            let count = CardsSettings.сardsInPack as Int
            countCardsLabel.text = String(count)
        }
    }
    
    @objc func minusCardsCountTapped(sender: UIButton) {
        if (CardsSettings.сardsInPack > 10) {
            CardsSettings.сardsInPack -= 5
            let count = CardsSettings.сardsInPack as Int
            countCardsLabel.text = String(count)
        }
    }
    
    @objc func plusCardsRepeatsTapped(sender: UIButton) {
        if (CardsSettings.сardsRepeats < 5) {
            CardsSettings.сardsRepeats += 1
            let count = CardsSettings.сardsRepeats as Int
            countRepeatsLabel.text = String(count)
        }
    }
    
    @objc func minusCardsRepeatsTapped(sender: UIButton) {
        if (CardsSettings.сardsRepeats > 1) {
            CardsSettings.сardsRepeats -= 1
            let count = CardsSettings.сardsRepeats as Int
            countRepeatsLabel.text = String(count)
        }
    }
    
    @objc func resetProgress(sender: UIButton) {
        // TODO: :)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
