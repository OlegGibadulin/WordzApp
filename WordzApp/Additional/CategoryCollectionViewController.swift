//
//  CategoryCollectionViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
//import RealmSwift

private let cellIdentifier = "CategoryCellId"

//private let sentences = [
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово"),
//    Sentence(text: "Sentence", translation: "Выражение"),
//    Sentence(text: "Word", translation: "Слово")
//]

private let sentences = [Sentence]()

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let realm = try! Realm()
//    lazy var sentences: Results<Sentence>! = {
//        self.realm.objects(Sentence.self)
//    }()
    
    let toCardsButton: UIButton = {
        let tcb = UIButton(type: .system)
        tcb.backgroundColor = .brown
        tcb.setTitle("Учить слова", for: .normal)
        tcb.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        tcb.tintColor = UIColor.white
        tcb.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tcb.addTarget(self, action: #selector(handleToCards), for: .touchUpInside)
        return tcb
    }()
    
    var categoryTitle = String()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width - 24, height: 10)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        setupLayout()
        setupNavigationItems()
    }
    
    @objc fileprivate func handleToCards() {
        //let cardViewController = UINavigationController(rootViewController: CardsViewController())
        let cardViewController = CardsViewController()
//        cardViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen

        navigationController?.pushViewController(cardViewController, animated: true)
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = categoryTitle
        
////        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.barTintColor = .red
//
//        navigationController?.navigationBar.tintColor = .red
//
////        navigationController?.navigationBar.backgroundColor = .red
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .lightRed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    fileprivate func setupLayout() {
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margins = CGFloat(12)
        return UIEdgeInsets(top: margins * 2, left: margins, bottom: 0, right: margins)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.sentence = sentences[indexPath.row]
    
        return cell
    }
}
