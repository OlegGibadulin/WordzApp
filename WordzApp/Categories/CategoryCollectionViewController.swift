//
//  CategoryCollectionViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

private let cellIdentifier = "CategoryCellId"

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let margins = CGFloat(12)
    
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
    }
    
    fileprivate func setupLayout() {
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margins * 2, left: margins, bottom: 0, right: margins)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = view.frame.width - margins * 2
//
////        let aWidth = width - 4 * 2
////        let size = CGSize(width: aWidth, height: 1000)
////        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: .medium)]
//
//        return CGSize(width: width, height: width)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margins
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margins
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
    
        return cell
    }
}
