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
    
    fileprivate let settingsButton: UIButton = {
        let sb = UIButton()
        sb.setImage(#imageLiteral(resourceName: "settingsIcon"), for: .normal)
        sb.setBlueStyle()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sb.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sb.addTarget(self, action: #selector(handleToSettings), for: .touchUpInside)
        return sb
    }()
        
    @objc fileprivate func handleToSettings() {
        // TODO:
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(collectionView)
        collectionView?.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        
        let topBarStackView = UIStackView(arrangedSubviews: [logoView, UIView(), settingsButton])
        topBarStackView.axis = .horizontal
        topBarStackView.distribution = .fill
        
        view.addSubview(topBarStackView)
        topBarStackView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: .sideMargin, bottom: 0, right: .sideMargin))
    }
    
}
