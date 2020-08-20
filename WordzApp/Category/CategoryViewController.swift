//
//  CategoryViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 22.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    internal var transparentView: UIView!
    internal var popup: AddFavouriteWordView!
    
    let addButton : UIButton = {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        addButton.setBlueStyle()
        addButton.backgroundColor = .blue
        addButton.layer.cornerRadius = 8
        addButton.setTitle("Add", for: .normal)
        return addButton
    }()
    
    var category: Category?
    
    internal lazy var categoryTableViewController: CategoryTableViewController = {
        let ctvc = CategoryTableViewController()
        ctvc.category = self.category
        return ctvc
    }()
    
    fileprivate var safeArea: UILayoutGuide!
    
    fileprivate lazy var tableView: UITableView = categoryTableViewController.tableView
    
    internal let toCardsButton: UIButton = {
        let tcb = UIButton(type: .system)
        tcb.setRedStyle()
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
        
        let countOfWords = CardsSettings.сardsInPack as Int
        var array = [Word]()
        
        // When count of words do not enough to equal User Defaults
        if (categoryTableViewController.sentences.count <= countOfWords) {
            categoryTableViewController.sentences.forEach { (sentence) in
                guard let text = sentence.text, let translate = sentence.translation else {
                    return
                }
                array.append(Word(word: text, translate: translate))
            }
        }
        // When enough count
        else {
            let categoryCount = categoryTableViewController.sentences.count
            for _ in 0..<countOfWords {
                while(true) {
                    let sentence = categoryTableViewController.sentences[Int.random(in: 0..<categoryCount)]
                    guard let text = sentence.text, let translate = sentence.translation else {
                        return
                    }
                    let word = Word(word: text, translate: translate)
                    
                    if array.contains(word) == false {
                        array.append(word)
                        break
                    }
                }
            }
        }
        
        cardViewController.words = array
        navigationController?.pushViewController(cardViewController, animated: true)
    }
    
    private func setupLayout() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 64, bottom: 16, right: 64))
        
//        updateToCardsButton(isHidden: false)
        if categoryTableViewController.tableView.visibleCells.isEmpty {
            toCardsButton.alpha = 0
        }
    }
    
    internal func updateToCardsButton(isHidden: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.toCardsButton.alpha = isHidden ? 0 : 1
        }, completion: nil)
    }
    
    internal func checkEmptyTableView() {
        if (toCardsButton.alpha < 1 &&
            categoryTableViewController.tableView.visibleCells.count > 0) {
            updateToCardsButton(isHidden: false)
        }
    }
    
    // MARK: NavigationController
    
    fileprivate lazy var backButton: UIButton = {
        let bb = UIButton()
        bb.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        bb.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        bb.setBlueStyle()
        bb.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return bb
    }()
    
    fileprivate func setupNavigationController() {
        let title = category?.title
        navigationItem.title = title
        
        if title == Storage.shared.favouritesTitle {
            addButton.addTarget(self, action: #selector(AddWordTapped(sender:)), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc fileprivate func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
