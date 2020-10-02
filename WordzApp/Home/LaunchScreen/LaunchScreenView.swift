//
//  LaunchScreenView.swift
//  WordzApp
//
//  Created by Антон Тимонин on 11.09.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class LaunchScreenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        self.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
