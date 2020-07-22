//
//  HomeCollectionViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
//import DGCollectionViewLeftAlignFlowLayout
import CollectionViewCenteredFlowLayout

private let cellIdentifier = "HomeCellId"
private let headerIdentifier = "HomeHeaderId"

private let categories = [
    Category(title: "Favourites", imageName: "favorites", firstColor: UIColor.gray, secondColor: UIColor.brown),
    Category(title: "Computer", imageName: "computer", firstColor: UIColor.gray, secondColor: UIColor.brown),
    Category(title: "Develop", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Sport", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Fitness", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Office", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Travel", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Cinema", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Food", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Fitness", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Office", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Travel", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Cinema", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Food", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Travel", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Cinema", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Food", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Fitness", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Office", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Travel", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Cinema", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue),
    Category(title: "Food", imageName: "calendar", firstColor: UIColor.lightRed, secondColor: UIColor.darkBlue)
]

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let margins = CGFloat(12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView!.register(HomeCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        collectionView.backgroundColor = .white
        
//        self.collectionView.collectionViewLayout = DGCollectionViewLeftAlignFlowLayout()
        
        self.collectionView.collectionViewLayout = CollectionViewCenteredFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let layout = UICollectionViewFlowLayout()
//        let categoryViewController = CategoryCollectionViewController(collectionViewLayout: layout)
        
        let categoryViewController = CategoryTableViewController()
        
        categoryViewController.categoryTitle = categories[indexPath.row].title
        
        present(UINavigationController(rootViewController: categoryViewController), animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margins * 2, left: margins, bottom: margins * 2, right: margins)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = view.frame.height / 2
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margins * 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margins
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = categories[indexPath.row].title
        let itemSize = title.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)
        ])
        return itemSize
        
//        let width = (view.frame.width - margins * 3) / 2
//        return CGSize(width: width, height: width)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.category = categories[indexPath.row]
    
        return cell
    }

}
