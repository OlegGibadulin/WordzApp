import UIKit
import CollectionViewCenteredFlowLayout

private let cellIdentifier = "HomeCellId"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // If this controller is used into another controller
    var rootViewController: UIViewController?
    
    var menuInteraction : UIContextMenuInteraction!
    
    fileprivate var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuInteraction = UIContextMenuInteraction(delegate: self)
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            UIContextMenuInteraction(delegate: self)
        }
        
        // Register cells
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        categories = CoreDataManager.shared.fetchNotHiddenCategories()
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
//        collectionView.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = CollectionViewCenteredFlowLayout()
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryViewController = CategoryViewController()
        categoryViewController.category = categories[indexPath.row]
        
        let vc = rootViewController ?? self
        vc.navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: .sideMargin, bottom: 40, right: .sideMargin)
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
        
        let menuInteraction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(menuInteraction)
    
        return cell
    }

}

extension HomeCollectionViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (suggestedAction) -> UIMenu? in
//            let action1 = UIAction(title: "KeK") {(_) in
//                print("action")
//            }
            return UIMenu(title: "", children: [])
        }
    }
}
