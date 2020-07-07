//
//  HomeCollectionViewCell.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    var backColor = UIColor()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayot()
        
        let image = UIImage(named: "computer")
        imageView.image = image
        
        titleLabel.text = "Computer"
        titleLabel.textAlignment = .center
        backColor = .lightGray
        backgroundColor = backColor
    }
    
    fileprivate func setupLayot() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        let imagePadding = frame.height / 4
        imageView.fillSuperview(padding: .init(top: imagePadding, left: imagePadding, bottom: imagePadding, right: imagePadding))
        
        addSubview(titleLabel)
        let titleBottomPadding = frame.height / 12
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: titleBottomPadding, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
