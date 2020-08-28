//
//  benefitsTableViewCell.swift
//  WordzApp
//
//  Created by Mac-HOME on 29.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

struct Benefit {
    let title: String
    let description: String
}

class BenefitsTableViewCell: UITableViewCell {
    
    var benefit: Benefit! {
        didSet {
            titleLabel.text = benefit.title
            descriptionLabel.text = benefit.description
        }
    }
    
    fileprivate let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        tl.numberOfLines = 0
        return tl
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        dl.numberOfLines = 0
        return dl
    }()
    
    fileprivate let checkImageView: UIImageView = {
        let civ = UIImageView(image: #imageLiteral(resourceName: "check"))
        civ.translatesAutoresizingMaskIntoConstraints = false
        civ.heightAnchor.constraint(equalToConstant: 40).isActive = true
        civ.widthAnchor.constraint(equalToConstant: 40).isActive = true
        civ.contentMode = .scaleAspectFill
        return civ
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        addSubview(checkImageView)
        checkImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil)
        
        let benefitStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        benefitStackView.axis = .vertical
        benefitStackView.distribution = .fill
        benefitStackView.spacing = 4

        addSubview(benefitStackView)
        benefitStackView.anchor(top: topAnchor, leading: checkImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 32, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
