//
//  CategoryCollectionViewCell.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        sl.numberOfLines = 0
        return sl
    }()
    
    let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tl.numberOfLines = 0
        return tl
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        sentenceLabel.text = "Sentence"
        translationLabel.text = "Выражение"
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let overallStackView = UIStackView(arrangedSubviews: [sentenceLabel, translationLabel])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 4

        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        widthAnchor.constraint(equalToConstant: frame.width - 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
