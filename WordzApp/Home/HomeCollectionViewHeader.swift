//
//  HomeCollectionViewHeader.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeCollectionViewHeader: UICollectionViewCell {
    
    let logoView: UIImageView = {
        let image = UIImage(named: "logo_black_small")
        let iv = UIImageView(image: image)
        iv.contentMode = .left
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return iv
    }()
    
    let profileView: UserProfileView = {
        let pv = UserProfileView()
        pv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return pv
    }()
    
    let cardDeskView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCards()
    }
    
    fileprivate func setupCards() {
        (0..<4).forEach { (_) in
            let cardView = CardView()
            cardDeskView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [logoView, profileView, cardDeskView])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 8
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
