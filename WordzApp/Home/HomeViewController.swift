import UIKit

protocol SettingsViewDelegate {
    func settingsViewWillDisappear()
}

class HomeViewController: UIViewController, SettingsViewDelegate {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 1.005)
    
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
    
    fileprivate let wordzContainter: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    fileprivate let cardzLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "cardz_orange"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    fileprivate let cardzContainter: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    fileprivate lazy var homeBackgroundHeaderView: HomeBackgroundHeaderView = {
        let hm = HomeBackgroundHeaderView(frame: self.view.frame)
        return hm
    }()
        
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationController()
    }
    
    // Update today sentences favourite state if it was deleted
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        view.addSubview(homeBackgroundHeaderView)
        todayCardsView.updateFavoriteState()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        wordzContainter.addSubview(wordzLogoView)
        cardzContainter.addSubview(cardzLogoView)
        
        containerView.addSubview(wordzContainter)
        containerView.addSubview(cardzContainter)
        containerView.addSubview(todayCardsView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(collectionView)
        
//        scrollView.addSubview(todayCardsView)
//        scrollView.addSubview(collectionView)
        setupLayout()
        
//        contentViewSize = CGSize(width: self.view.frame.width, height: todayCardsView.frame.height + collectionView.contentSize.height + cardzLogoView.frame.height)
//        containerView.frame.size = contentViewSize
//        scrollView.contentSize = contentViewSize
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // x y width height
        print(collectionView.contentSize.height)
        
    }
    
    fileprivate func setupLayout() {
//        let screenWidth = UIScreen.main.bounds.width
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        scrollView.backgroundColor = .green
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
//
//        print(view.frame)
//        print()
//
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        wordzContainter.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        wordzContainter.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        wordzContainter.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        wordzContainter.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        cardzLogoView.topAnchor.constraint(equalTo: cardzContainter.topAnchor, constant: -10).isActive = true
        wordzLogoView.leftAnchor.constraint(equalTo: wordzContainter.leftAnchor, constant: 25).isActive = true
        wordzLogoView.centerYAnchor.constraint(equalTo: wordzContainter.centerYAnchor).isActive = true
//        cardzLogoView.centerXAnchor.constraint(equalTo: cardzContainter.centerXAnchor).isActive = true
        wordzLogoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        wordzLogoView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        todayCardsView.topAnchor.constraint(equalTo: wordzContainter.bottomAnchor, constant: 20).isActive = true
        todayCardsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        todayCardsView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        todayCardsView.heightAnchor.constraint(equalToConstant: .todayCardHeight).isActive = true
        
        cardzContainter.topAnchor.constraint(equalTo: todayCardsView.bottomAnchor, constant: 10).isActive = true
        cardzContainter.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        cardzContainter.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        cardzContainter.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
//        cardzLogoView.topAnchor.constraint(equalTo: cardzContainter.topAnchor, constant: -10).isActive = true
        cardzLogoView.leftAnchor.constraint(equalTo: cardzContainter.leftAnchor, constant: 25).isActive = true
        cardzLogoView.centerYAnchor.constraint(equalTo: cardzContainter.centerYAnchor).isActive = true
//        cardzLogoView.centerXAnchor.constraint(equalTo: cardzContainter.centerXAnchor).isActive = true
        cardzContainter.bringSubviewToFront(cardzLogoView)
        cardzLogoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cardzLogoView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        
//        todayCardsView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 120, left: .sideMargin * 2, bottom: 0, right: .sideMargin * 2), size: .init(width: 0, height: .todayCardHeight))
//
//        collectionView.frame = CGRect(x: 0, y: todayCardsView.frame.height, width: screenWidth, height: collectionView.contentSize.height)
//
        collectionView.topAnchor.constraint(equalTo: cardzContainter.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 1000).isActive = true

//        collectionView.heightAnchor.constraint(equalToConstant: collectionView.contentSize.height).isActive = true
//        collectionView?.anchor(top: todayCardsView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: -8, bottom: 0, right: -8))
        
        
        
        

//        scrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    
    
    // Update today sentences if level has been changed
    func settingsViewWillDisappear() {
        todayCardsViewController.updateTodaySentences()
    }
    
    // MARK: NavigationController
    
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
