import UIKit
import CollectionViewCenteredFlowLayout

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate let todayCardsViewController: TodayCardsViewController = {
        let tcvc = TodayCardsViewController()
        tcvc.view.translatesAutoresizingMaskIntoConstraints = false
        return tcvc
    }()
    
    fileprivate lazy var todayCardsView: TodayCardView = self.todayCardsViewController.view! as! TodayCardView
    
    lazy var HeaderSectionSize = CGSize(width: UIScreen.main.bounds.width - 42, height: 475)
    
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
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView!.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        
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
        switch indexPath.section {
        case 1:
            let categoryViewController = CategoryViewController()
            categoryViewController.category = categories[indexPath.row]
            
            let vc = rootViewController ?? self
            vc.navigationController?.pushViewController(categoryViewController, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 1:
            return UIEdgeInsets(top: 0, left: .sideMargin, bottom: 20, right: .sideMargin)
        default:
            return UIEdgeInsets(top: 0, left: .sideMargin, bottom: 0, right: .sideMargin)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            guard let title = categories[indexPath.row].title else { return CGSize(width: 0, height: 0) }
            
            let itemSize = title.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)
            ])
            return itemSize
        default:
            return HeaderSectionSize
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return categories.count
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
            
            cell.category = categories[indexPath.row]
            
            let menuInteraction = UIContextMenuInteraction(delegate: self)
            cell.addInteraction(menuInteraction)
        
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as! HeaderCollectionViewCell
            cell.setup(todayView: todayCardsView)
            
            return cell
        }
    }

}

extension HomeCollectionViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (suggestedAction) -> UIMenu? in
            return UIMenu(title: "", children: [])
        }
    }
}
