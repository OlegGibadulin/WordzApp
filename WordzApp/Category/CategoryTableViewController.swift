//
//  CategoryTableViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
//import WLEmptyState
//import EmptyDataSet_Swift
import UIEmptyState

private let cellIdentifier = "CategoryCellId"

private let sentences = [
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово"),
    Sentence(text: "Sentence", translation: "Выражение"),
    Sentence(text: "Word", translation: "Слово")
]

//private let sentences: [Sentence] = []

class CategoryTableViewController: UITableViewController, UIEmptyStateDelegate, UIEmptyStateDataSource {
    
    var categoryTitle = String()
    
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
        
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        
        self.reloadEmptyState()
        
//        tableView.emptyStateDataSource = self
//        tableView.emptyDataSetSource = self
//        tableView.emptyDataSetDelegate = self
        
        setupLayout()
        setupNavigationController()
    }
    
    var emptyStateImage: UIImage? {
        return #imageLiteral(resourceName: "bookmark_white")
    }

    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.882, green: 0.890, blue: 0.859, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: "Здесь пока пусто", attributes: attrs)
    }
    
    fileprivate func setupLayout() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        
        tableView.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func setupNavigationController() {
        navigationItem.title = categoryTitle
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc fileprivate func handleToCards() {
        let cardViewController = UINavigationController(rootViewController: CardsViewController())
        present(cardViewController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        
        cell.sentence = sentences[indexPath.row]

        return cell
    }
}
