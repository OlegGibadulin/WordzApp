import UIKit

protocol SettingsViewDelegate {
    func settingsViewWillDisappear()
}

class HomeViewController: UIViewController, SettingsViewDelegate {
    
    // MARK:- Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 1.2)
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = view.bounds
        sv.contentSize = contentViewSize
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.frame.size = contentViewSize
        return v
    }()
    
    fileprivate let todayCardsViewController: TodayCardsViewController = {
        let tcvc = TodayCardsViewController()
        tcvc.view.translatesAutoresizingMaskIntoConstraints = false
        return tcvc
    }()
    
    fileprivate lazy var todayCardsView: TodayCardView = self.todayCardsViewController.view! as! TodayCardView
    
    fileprivate lazy var homeCollectionViewController: HomeCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let hcvc = HomeCollectionViewController(collectionViewLayout: layout)
        hcvc.view.translatesAutoresizingMaskIntoConstraints = false
        hcvc.rootViewController = self
        return hcvc
    }()
    
    fileprivate lazy var collectionView: UICollectionView! = homeCollectionViewController.collectionView
    
    fileprivate let wordzLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "wordz_gray"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    fileprivate let cardzLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "cardz_orange"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    fileprivate lazy var homeBackgroundHeaderView: HomeBackgroundHeaderView = {
        let hm = HomeBackgroundHeaderView(frame: self.view.frame)
        return hm
    }()

    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todayCardsView.updateFavoriteState()
    }
    
    //MARK:- ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        layout()
    }
    
    // MARK:- Setup
    fileprivate func setup() {
        setupMainView()
        setupNavigationController()
        setupScrollView()
        setupContainerView()
    }
    
    fileprivate func setupMainView() {
        view.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        view.addSubview(homeBackgroundHeaderView)
        view.addSubview(scrollView)
    }
    
    fileprivate func setupScrollView() {
        scrollView.addSubview(containerView)
    }
    
    fileprivate func setupContainerView() {
        containerView.addSubview(wordzLogoView)
        containerView.addSubview(cardzLogoView)
        containerView.addSubview(todayCardsView)
        containerView.addSubview(collectionView)
    }
    
    //MARK:- Layout
    fileprivate func layout() {
        layoutScrollView()
    }
    
    fileprivate func layoutScrollView() {
        resizeScrollView()
        
        wordzLogoView.anchor(top: containerView.topAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: nil, trailing: nil,
                             padding: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0),
                             size: .init(width: 120, height: 30))
        
        todayCardsView.anchor(top: wordzLogoView.bottomAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: nil,
                             trailing: containerView.trailingAnchor,
                             padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 20),
                             size: .init(width: 0, height: .todayCardHeight))
        
        cardzLogoView.anchor(top: todayCardsView.bottomAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: nil, trailing: nil,
                             padding: UIEdgeInsets(top: 30, left: 25, bottom: 0, right: 0),
                             size: .init(width: 120, height: 30))
        
        collectionView.anchor(top: cardzLogoView.bottomAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: nil,
                             trailing: containerView.trailingAnchor,
                             padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0),
                             size: .init(width: 0, height: 1000))
        
        
    }
    
    fileprivate func resizeScrollView() {
        var newHeight: CGFloat = 20 + 30 + 30 + 20
        newHeight += wordzLogoView.frame.height
        newHeight += todayCardsView.frame.height
        newHeight += cardzLogoView.frame.height
        newHeight += collectionView.frame.height
        
        let screenFrame = self.view.frame
        if screenFrame.height != 0 {
            var num = screenFrame.height * (newHeight / screenFrame.height)
            contentViewSize = CGSize(width: screenFrame.width, height: num )
            containerView.frame.size = CGSize(width: screenFrame.width, height: num )
        }
        
//        scrollView.contentSize = contentViewSize
    }
    
    // MARK:- Delegate SettingsView
    func settingsViewWillDisappear() {
        todayCardsViewController.updateTodaySentences()
    }
    
    // MARK: Setup NavigationController
    fileprivate lazy var settingsButton: UIButton = {
        let sb = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        sb.setImage(#imageLiteral(resourceName: "settingsIcon"), for: .normal)
        sb.setBlueStyle()
        sb.addTarget(self, action: #selector(handleSettingsButtonTapped), for: .touchUpInside)
        return sb
    }()
    
    fileprivate func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    fileprivate lazy var settingsViewController: SettingsViewController = {
        let svc = SettingsViewController()
        svc.delegate = self
        svc.keyWindow = self.view.window
        return svc
    }()

    @objc fileprivate func handleSettingsButtonTapped() {
        settingsViewController.show()
    }
}
