//
//  CategoryViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 22.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categoryTitle = String()
    
    lazy var categoryTableViewController: CategoryTableViewController! = {
        let ctvc = CategoryTableViewController()
        
        ctvc.scrollDirectionObserver = { [weak self] (direction) in
            if direction == 0 {
                // UP
                self?.toCardsButton.isHidden = false
            } else {
                // DOWN
                self?.toCardsButton.isHidden = true
            }
        }
        
        return ctvc
    }()
    
    lazy var tableView: UITableView! = {
        let tv = self.categoryTableViewController.tableView
        return tv
    }()
    
    var safeArea: UILayoutGuide!
    
    let toCardsButton: UIButton = {
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
        let cardViewController = UINavigationController(rootViewController: CardsViewController())
        present(cardViewController, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(tableView)
        tableView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 64, bottom: 0, right: 64))
    }
    
    fileprivate func setupNavigationController() {
        navigationItem.title = categoryTitle
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
