//
//  HomeCollectionViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import CollectionViewCenteredFlowLayout

private let cellIdentifier = "HomeCellId"
private let headerIdentifier = "HomeHeaderId"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // If this controller is used into another controller
    var rootViewController: UIViewController?
    
    fileprivate var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView!.register(HomeCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
//        CoreDataManager.shared.addCategory(title: "Computer", firstColor: .darkBlue, secondColor: .lightRed)
        
        categories = CoreDataManager.shared.fetchCategories()
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.collectionViewLayout = CollectionViewCenteredFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryViewController = CategoryViewController()
        categoryViewController.category = categories[indexPath.row]
//
//        let categoryNavController = UINavigationController(rootViewController: categoryViewController)
//        categoryNavController.modalPresentationStyle = .fullScreen
        
        let vc = rootViewController ?? self
//        vc.present(categoryNavController, animated: true, completion: nil)
        
        vc.navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: .sideMargin, bottom: 40, right: .sideMargin)
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let title = categories[indexPath.row].title else { return CGSize(width: 0, height: 0) }
        
        let itemSize = title.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)
        ])
        return itemSize
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
