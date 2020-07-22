//
//  UserProfileView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class UserProfileView: UIView {
    
//    let informationLabel: UILabel {
//
//    }
//
//    let imageView: UIImageView {
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
