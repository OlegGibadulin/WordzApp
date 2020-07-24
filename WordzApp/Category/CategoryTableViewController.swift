//
//  CategoryTableViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import CoreData

private let cellIdentifier = "CategoryCellId"

class CategoryTableViewController: UITableViewController {
    
    var category: Category?
    
    private var sentences = [Sentence]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registeration
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
//        CoreDataManager.shared.addSentence(text: "Sentence", translation: "Предложение", category: category)
        
        sentences = CoreDataManager.shared.fetchSentences(category: category)
        
        setupLayout()
        setupEmptyState()
    }
    
    fileprivate func setupLayout() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
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
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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
        deleteAction.backgroundColor = .lightRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
