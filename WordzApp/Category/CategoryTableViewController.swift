//
//  CategoryTableViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import UIEmptyState
import CoreData

private let cellIdentifier = "CategoryCellId"

class CategoryTableViewController: UITableViewController, UIEmptyStateDelegate, UIEmptyStateDataSource {
    
    private var sentences = [Sentence]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registeration
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
//        CoreDataDB.addSentence(text: "Word", translation: "Слово")
//        CoreDataDB.addSentence(text: "Translation", translation: "Перевод")
        
        fetchSentences()
        setupLayout()
        setupEmptyState()
    }
    
    fileprivate func fetchSentences() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Sentence>(entityName: "Sentence")
        
        do {
            let sentences = try context.fetch(fetchRequest)
            self.sentences = sentences
            self.tableView.reloadData()
        } catch let fetchErr {
            print("Failed to fetch sentences:", fetchErr)
        }
    }
    
    fileprivate func setupLayout() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
    }
    
    var emptyStateImage: UIImage? {
        return #imageLiteral(resourceName: "bookmark_white")
    }

    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.882, green: 0.890, blue: 0.859, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: "Здесь пока пусто", attributes: attrs)
    }
    
    fileprivate func setupEmptyState() {
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        self.reloadEmptyState()
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, complete) in
            
            let sentence = self.sentences[indexPath.row]
            
            // delete from tableview
            self.sentences.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // delete from CoreData
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(sentence)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete sentence:", saveErr)
            }
            
            self.reloadEmptyState()
            complete(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    var scrollDirectionObserver: ((Int) -> ())?

    private var lastContentOffset: CGFloat = 0

    private var direction = 0 {
        didSet {
            scrollDirectionObserver?(direction)
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
            print("up")
            direction = 0
        } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            print("down")
            direction = 1
        }

        lastContentOffset = scrollView.contentOffset.y
    }
}
