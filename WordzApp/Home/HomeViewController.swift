//
//  HomeViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate {
    func settingsViewWillDisappear()
}

class HomeViewController: UIViewController, SettingsViewDelegate {
    
    fileprivate let todayCardsViewController = TodayCardsViewController()
    
    fileprivate lazy var todayCardsView: TodayCardView = self.todayCardsViewController.view! as! TodayCardView
    
    fileprivate lazy var homeCollectionViewController: HomeCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let hcvc = HomeCollectionViewController(collectionViewLayout: layout)
        hcvc.rootViewController = self
        return hcvc
    }()
    
    fileprivate lazy var collectionView: UICollectionView! = homeCollectionViewController.collectionView
    
    fileprivate let wordsLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "wordz_gray"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    fileprivate lazy var homeBackgroundHeaderView = HomeBackgroundHeaderView(frame: self.view.frame)
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationController()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        
        view.addSubview(homeBackgroundHeaderView)
        
        view.addSubview(todayCardsView)
        todayCardsView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 120, left: .sideMargin * 2, bottom: 0, right: .sideMargin * 2), size: .init(width: 0, height: .todayCardHeight))
        
        view.addSubview(collectionView)
        collectionView?.anchor(top: todayCardsView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
    }
    
    // Update today sentences favourite state if it was deleted
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todayCardsView.updateFavoriteState()
    }
    
    // Update today sentences if level has been changed
    func settingsViewWillDisappear() {
        todayCardsViewController.updateTodaySentences()
    }
    
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
    
    fileprivate lazy var settingsViewController: SettingsViewController = {
        let svc = SettingsViewController()
        svc.delegate = self
        svc.keyWindow = self.view.window
        return svc
    }()

    @objc fileprivate func handleSettingsButtonTapped() {
        settingsViewController.show()
    }
    
}
