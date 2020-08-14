//
//  CardLoadingView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 14.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    private var activityIndicator: UIActivityIndicatorView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupActivityIndicator()
    }
    
    public func setupActivityIndicator() {
        let width: CGFloat = self.frame.width
        let height: CGFloat = self.frame.height
        let activitySide: CGFloat = 50
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: (width - activitySide) / 2 , y: (height - activitySide) / 2, width: activitySide, height: activitySide))
        self.addSubview(activityIndicator)
        startLoading()
    }
    
    public func startLoading() {
        activityIndicator.startAnimating()
    }
    
    public func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        self.layer.cornerRadius = 23
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
