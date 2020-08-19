//
//  HeaderView.swift
//  HeaderView
//
//  Created by Антон Тимонин on 17.08.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var customViewWidth: CGFloat = 0
    var customViewHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customViewWidth = frame.width
        customViewHeight = 220
        
        setupView()
    }
    
    func setupView() {
        
        self.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        self.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 23)
        self.frame = CGRect(x: 0, y: 0, width: customViewWidth, height: customViewHeight)
        
        let circle1 = UIView()
        circle1.backgroundColor = #colorLiteral(red: 0, green: 0.08235294118, blue: 1, alpha: 1)
        circle1.translatesAutoresizingMaskIntoConstraints = false
        let circle1Radius = self.frame.width / 2
        circle1.layer.cornerRadius = circle1Radius / 2
        
        let circle2 = UIView()
        circle2.translatesAutoresizingMaskIntoConstraints = false
        circle2.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.7607843137, alpha: 1)
        let circle2Radius = self.frame.width * 0.625
        //circle2.frame = CGRect(x: customViewWidth * 0.68, y: customViewHeight * (-0.65), width: circle2Radius, height: circle2Radius)
        circle2.layer.cornerRadius = circle2Radius / 2
        
        let circle3 = UIView()
        circle3.translatesAutoresizingMaskIntoConstraints = false
        circle3.backgroundColor = #colorLiteral(red: 0, green: 0.8196078431, blue: 1, alpha: 1)
        let circle3Radius = self.frame.width * 0.89
        circle3.layer.cornerRadius = circle3Radius / 2
        
        let image = UIImage(named: "wordz_gray")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(circle1)
        self.addSubview(circle2)
        self.addSubview(circle3)
        
        self.addSubview(imageView)
        
        self.layer.cornerRadius = 8
        self.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        circle1.widthAnchor.constraint(equalToConstant: circle1Radius).isActive = true
        circle1.heightAnchor.constraint(equalToConstant: circle1Radius).isActive = true
        circle1.topAnchor.constraint(equalTo: self.topAnchor, constant: customViewWidth * (-0.2)).isActive = true
        circle1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: customViewWidth * (-0.275)).isActive = true
        
        circle2.widthAnchor.constraint(equalToConstant: circle2Radius).isActive = true
        circle2.heightAnchor.constraint(equalToConstant: circle2Radius).isActive = true
        circle2.topAnchor.constraint(equalTo: self.topAnchor, constant: customViewWidth * (-0.385)).isActive = true
        circle2.leftAnchor.constraint(equalTo: self.rightAnchor, constant: customViewWidth * (-0.32)).isActive = true
        
        circle3.widthAnchor.constraint(equalToConstant: circle3Radius).isActive = true
        circle3.heightAnchor.constraint(equalToConstant: circle3Radius).isActive = true
        circle3.topAnchor.constraint(equalTo: circle2.bottomAnchor, constant: 17.5).isActive = true
        circle3.leftAnchor.constraint(equalTo: self.rightAnchor, constant: customViewWidth * (-0.32)).isActive = true
        
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: customViewHeight * (-0.16)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
