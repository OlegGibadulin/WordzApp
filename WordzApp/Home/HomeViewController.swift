//
//  HomeViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate lazy var homeCollectionViewController: HomeCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let hcvc = HomeCollectionViewController(collectionViewLayout: layout)
        hcvc.rootViewController = self
        return hcvc
    }()
    
    fileprivate lazy var collectionView: UICollectionView! = homeCollectionViewController.collectionView
    
    fileprivate var safeArea: UILayoutGuide!
    
    fileprivate let logoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "logo_black_small"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lv.widthAnchor.constraint(equalToConstant: 130).isActive = true
        lv.contentMode = .scaleAspectFill
        return lv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationController()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(collectionView)
        collectionView?.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        
        let topBarStackView = UIStackView(arrangedSubviews: [logoView, UIView()])
        topBarStackView.axis = .horizontal
        topBarStackView.distribution = .fill
        
        view.addSubview(topBarStackView)
        topBarStackView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: .sideMargin, bottom: 0, right: .sideMargin))
    }
    
    fileprivate lazy var settingsViewController: SettingsViewController = {
        let svc = SettingsViewController()
        svc.keyWindow = self.view.window
        return svc
    }()
    
    // MARK: NavigationController
    
    fileprivate lazy var settingsButton: UIButton = {
        let sb = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        sb.setImage(#imageLiteral(resourceName: "settingsIcon"), for: .normal)
        sb.setBlueStyle()
        sb.addTarget(self, action: #selector(handleSettingsButtonTapped), for: .touchUpInside)
        return sb
    }()
    
    fileprivate func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }

    @objc fileprivate func handleSettingsButtonTapped() {
        settingsViewController.show()
    }
    
}
