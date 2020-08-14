//
//  SettingsView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    fileprivate let items = ["Beginner", "Intermediate", "Advanced"]
    fileprivate let ru_items = ["Начинающий", "Средний", "Продвинутый"]
    
    fileprivate lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: self.ru_items)
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    fileprivate let infoLabel: UILabel = {
        let il = UILabel()
        il.textAlignment = .center
        il.textColor = .gray
        il.text = "Выберите сложность ежедневных слов"
        return il
    }()
    
    fileprivate let topBar: UIView = {
        let tb = UIView()
        tb.layer.cornerRadius = 2
        tb.clipsToBounds = true
        tb.backgroundColor = .lightGray
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tb.heightAnchor.constraint(equalToConstant: 4).isActive = true
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    fileprivate func setupLayout() {
        layer.cornerRadius = 23
        clipsToBounds = true
        backgroundColor = .white
        
        addSubview(topBar)
        topBar.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        topBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let overallStackView = UIStackView(arrangedSubviews: [infoLabel, segmentedControl, UIView()])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 20
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 40, left: .sideMargin, bottom: 0, right: .sideMargin))
    }
    
    @objc fileprivate func handleSegmentChange() {
        let defaults = UserDefaults.standard
        defaults.set(segmentedControl.selectedSegmentIndex, forKey: "LevelIndex")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
