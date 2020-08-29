//
//  SettingsView.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    fileprivate let segmentedControl: UISegmentedControl = {
        let levels = CoreDataManager.shared.fetchLevels()
        let levelsTitle = levels.compactMap { (level) -> String? in
            return level.title
        }
        
        let sc = UISegmentedControl(items: levelsTitle)
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        let defaults = UserDefaults.standard
        sc.selectedSegmentIndex = defaults.integer(forKey: "LevelIndex")
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
        
//        segmentedControl.isEnabledForSegment(at: 2) = true
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
    
    fileprivate lazy var purchaseViewController: ProVersionPurchaseViewController = {
        let pvc = ProVersionPurchaseViewController()
        pvc.keyWindow = self.window
        return pvc
    }()
    
    fileprivate var prevSegmentIndex: Int = {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "LevelIndex")
    }()
    
    @objc fileprivate func handleSegmentChange() {
        if segmentedControl.selectedSegmentIndex == 2 {
            // Advanced level is in pro version of app
            segmentedControl.selectedSegmentIndex = prevSegmentIndex
            purchaseViewController.show()
        } else {
            prevSegmentIndex = segmentedControl.selectedSegmentIndex
            let defaults = UserDefaults.standard
            defaults.set(segmentedControl.selectedSegmentIndex, forKey: "LevelIndex")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
