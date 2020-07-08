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
    let gradientLayer = CAGradientLayer()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tl.textAlignment = .center
        return tl
    }()
    
    var category: Category? {
        didSet {
            if let ctg = category {
                titleLabel.text = ctg.title
                
                let image = UIImage(named: ctg.imageName)
                imageView.image = image
                
                gradientLayer.colors = [ctg.firstColor.cgColor, ctg.secondColor.cgColor]
                gradientLayer.locations = [1, 1]
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayot()
    }
    
    fileprivate func setupLayot() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        layer.addSublayer(gradientLayer)
        
        addSubview(imageView)
        let imagePadding = frame.height / 4
        imageView.fillSuperview(padding: .init(top: imagePadding, left: imagePadding, bottom: imagePadding, right: imagePadding))
        
        addSubview(titleLabel)
        let titleBottomPadding = frame.height / 12
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: titleBottomPadding, right: 0))
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
