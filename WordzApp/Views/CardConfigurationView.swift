//
//  CardsConfigurationView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 17.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CardsConfigurationView: UIView {
    
    // 1 Line - count words in pack
    var сardsInPackLabel : UILabel!
    var countCardsLabel : UILabel!
    var plusCardsCountButton: UIButton!
    var minusCardsCountButton: UIButton!
    var firstLineStackView: UIStackView!
    
    // 2 Line - count repeats wordz
    var сardsRepeatsLabel : UILabel!
    var countRepeatsLabel : UILabel!
    var plusCardsRepeatsButton: UIButton!
    var minusCardsRepeatsButton: UIButton!
    var secondLineStackView: UIStackView!
    
    // 3 Line - discard all settings
    var discardButton: UIButton!
    var thirdLineStackView: UIStackView!
    
    var overallStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFirstLine()
        setupSecondLine()
        setupThirdLine()
        setupOverallStackview()
        setupAnchors()
    }
    
    func setupFirstLine() {
        сardsInPackLabel = UILabel()
        сardsInPackLabel.text = "Слов в стопке: "
        сardsInPackLabel.textAlignment = .left
        
        countCardsLabel = UILabel()
        countCardsLabel.text = "20"
        countCardsLabel.textAlignment = .center
        
        
        plusCardsCountButton = UIButton()
        guard let plusImage = UIImage(named: "plusIcon") else { return }
        var resizedImage: UIImage = plusImage.resizeImage(image: plusImage, targetSize: CGSize(width: 20, height: 20))
        plusCardsCountButton.setImage(resizedImage, for: .normal)
        plusCardsCountButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        plusCardsCountButton.layer.cornerRadius = 8
        
        minusCardsCountButton = UIButton()
        guard let minusImage = UIImage(named: "minusIcon") else { return }
        resizedImage = minusImage.resizeImage(image: minusImage, targetSize: CGSize(width: 20, height: 20))
        minusCardsCountButton.setImage(resizedImage, for: .normal)
        minusCardsCountButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        minusCardsCountButton.layer.cornerRadius = 8
        
        
        
        let view1 = UIView()
        
        firstLineStackView = UIStackView(arrangedSubviews: [сardsInPackLabel, view1, minusCardsCountButton, countCardsLabel, plusCardsCountButton])
        
        firstLineStackView.axis = .horizontal
        firstLineStackView.distribution = .equalSpacing
        firstLineStackView.spacing = 10
        widthAnchor.constraint(equalToConstant: frame.width - 100).isActive = true
    }
    
    func setupSecondLine() {
        сardsRepeatsLabel = UILabel()
        сardsRepeatsLabel.text = "Повторов каждого слова: "
        сardsRepeatsLabel.textAlignment = .left
        
        countRepeatsLabel = UILabel()
        countRepeatsLabel.text = "10"
        countRepeatsLabel.textAlignment = .center
        
        plusCardsRepeatsButton = UIButton()
        guard let plusImage = UIImage(named: "plusIcon") else { return }
        var resizedImage: UIImage = plusImage.resizeImage(image: plusImage, targetSize: CGSize(width: 20, height: 20))
        plusCardsRepeatsButton.setImage(resizedImage, for: .normal)
        plusCardsRepeatsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        plusCardsRepeatsButton.layer.cornerRadius = 8
        
        minusCardsRepeatsButton = UIButton()
        guard let minusImage = UIImage(named: "minusIcon") else { return }
        resizedImage = minusImage.resizeImage(image: minusImage, targetSize: CGSize(width: 20, height: 20))
        minusCardsRepeatsButton.setImage(resizedImage, for: .normal)
        minusCardsRepeatsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        minusCardsRepeatsButton.layer.cornerRadius = 8
        
        let view1 = UIView()
        
        secondLineStackView = UIStackView(arrangedSubviews: [сardsRepeatsLabel, view1, minusCardsRepeatsButton, countRepeatsLabel, plusCardsRepeatsButton, view1])
        
        secondLineStackView.axis = .horizontal
        secondLineStackView.distribution = .equalCentering
        secondLineStackView.spacing = 10
        
    }
    
    func setupThirdLine() {
        
        let view = UIView()
        discardButton = UIButton()
        discardButton.setTitle("Сбросить прогресс", for: .normal)
        discardButton.backgroundColor = .clear
        discardButton.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        discardButton.setTitleColor(#colorLiteral(red: 0.7121704221, green: 0.1806949675, blue: 0.08742617816, alpha: 1), for: .highlighted)
        discardButton.layer.cornerRadius = 8
        discardButton.titleLabel?.textAlignment = .left
        
        thirdLineStackView = UIStackView(arrangedSubviews: [discardButton, view])
        thirdLineStackView.axis = .horizontal
//        thirdLineStackView.distribution = .fill
        thirdLineStackView.spacing = 10
    }
    
    func setupOverallStackview() {
        let view = UIView()
        
        overallStackView = UIStackView(arrangedSubviews: [firstLineStackView, view, secondLineStackView, view, thirdLineStackView, view])
        overallStackView.spacing = 10
        overallStackView.axis = .vertical
        overallStackView.distribution = .fillEqually
        
        self.addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 15, left: 20, bottom: 95, right: 15))
    }
    
    func setupAnchors() {
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
        
//        plusCardsRepeatsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        plusCardsRepeatsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        minusCardsRepeatsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        minusCardsRepeatsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        countRepeatsLabel
//        plusCardsRepeatsButton
//        minusCardsRepeatsButton
        
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        firstLineStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        secondLineStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLineStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        thirdLineStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdLineStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
