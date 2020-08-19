//
//  CardLoadingView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 14.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import Lottie

final class LoadingView: UIView {
    private var animationView: AnimationView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupAnimationView()
        setupImage()
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        self.layer.cornerRadius = 23
    }
    
    fileprivate func setupAnimationView() {
        let width: CGFloat = self.frame.width
        let height: CGFloat = self.frame.height
        let activitySide: CGFloat = width / 2
        
        animationView = .init(name: "loading_animation")
        animationView.frame = CGRect(x: (width - activitySide) / 2 , y: (height - activitySide) / 2.25, width: activitySide, height: activitySide)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        self.addSubview(animationView)
        startLoading()
    }
    
    fileprivate func setupImage() {
        let image = UIImage(named: "cardz_line")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    public func startLoading() {
        animationView.play()
    }
    
    public func stopLoading() {
        animationView.stop()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
