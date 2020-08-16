//
//  CategoryViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 22.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var category: Category?
    
    fileprivate lazy var categoryTableViewController: CategoryTableViewController = {
        let ctvc = CategoryTableViewController()
        ctvc.category = self.category
        return ctvc
    }()
    
    fileprivate var safeArea: UILayoutGuide!
    
    fileprivate lazy var tableView: UITableView = categoryTableViewController.tableView
    
    fileprivate let toCardsButton: UIButton = {
        let tcb = UIButton(type: .system)
        tcb.backgroundColor = .lightRed
        tcb.setTitle("Учить слова", for: .normal)
        tcb.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        tcb.tintColor = .white
        tcb.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tcb.addTarget(self, action: #selector(handleToCards), for: .touchUpInside)
        return tcb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationController()
    }
    
    @objc fileprivate func handleToCards() {
        let cardViewController = CardsViewController()
        cardViewController.category = category
        navigationController?.pushViewController(cardViewController, animated: true)
    }
    
    private func setupLayout() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 64, bottom: 16, right: 64))
    }
    
    // MARK: NavigationController
    
    fileprivate lazy var backButton: UIButton = {
        let bb = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        bb.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        bb.setBlueStyle()
        bb.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return bb
    }()
    
    fileprivate func setupNavigationController() {
        navigationItem.title = category?.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc fileprivate func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
