//
//  CategoryTableViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

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

class CategoryTableViewController: UITableViewController {
    
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
        
        setupLayout()
        setupNavigationController()
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
