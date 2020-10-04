import UIKit

class SettingsView: UIView {
    
    fileprivate let segmentedControl: UISegmentedControl = {
        let levels = CoreDataManager.shared.fetchLevels()
        let levelsTitle = levels.compactMap { (level) -> String? in
            return level.title
        }
        
        let sc = UISegmentedControl(items: levelsTitle)
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        let defaults = UserDefaults.standard
        sc.selectedSegmentIndex = defaults.integer(forKey: "LevelIndex")
        return sc
    }()
    
    fileprivate let infoLabel: UILabel = {
        let il = UILabel()
        il.textAlignment = .center
        il.textColor = .gray
        il.text = "Выберите сложность ежедневных слов"
        return il
    }()
    
    fileprivate let topBar: UIView = {
        let tb = UIView()
        tb.layer.cornerRadius = 2
        tb.clipsToBounds = true
        tb.backgroundColor = .lightGray
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tb.heightAnchor.constraint(equalToConstant: 4).isActive = true
        return tb
    }()
    
    fileprivate let restoreButton: UIButton = {
       let rab = UIButton()
        rab.layer.cornerRadius = 8
        rab.setTitle("Восстановление покупок", for: .normal)
        rab.setTitleColor(#colorLiteral(red: 0.2479351461, green: 0.3350306749, blue: 1, alpha: 1), for: .normal)
        rab.setTitleColor(#colorLiteral(red: 0.1432796419, green: 0.1963309944, blue: 0.6008853316, alpha: 1), for: .highlighted)
        rab.backgroundColor = .clear
        rab.contentHorizontalAlignment = .left
        rab.titleLabel?.textAlignment = .left
        rab.translatesAutoresizingMaskIntoConstraints = false
        return rab
    }()
    
    fileprivate let removeAdsButton: UIButton = {
       let rab = UIButton()
        rab.layer.cornerRadius = 8
        rab.setTitle("Отключить рекламу", for: .normal)
        rab.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        rab.setTitleColor(#colorLiteral(red: 0.2479351461, green: 0.3350306749, blue: 1, alpha: 1), for: .highlighted)
        rab.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        rab.translatesAutoresizingMaskIntoConstraints = false
        return rab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        
//        segmentedControl.isEnabledForSegment(at: 2) = true
    }

    fileprivate func setupLayout() {
        layer.cornerRadius = 23
        clipsToBounds = true
        backgroundColor = UIColor.appColor(.white_lightgray)
        
        addSubview(topBar)
        topBar.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        topBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let overallStackView = UIStackView(arrangedSubviews: [infoLabel, segmentedControl, removeAdsButton, restoreButton, UIView()])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 20
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 40, left: .sideMargin, bottom: 0, right: .sideMargin))
        
        restoreButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
//        restoreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        removeAdsButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        restoreButton.addTarget(self, action: #selector(restorePurchases), for: .touchUpInside)
        removeAdsButton.addTarget(self, action: #selector(handlePurchase), for: .touchUpInside)
        changeStateButtons(isFullVersion: Purchases.fullVersion)
    }
    
    fileprivate func changeStateButtons(isFullVersion: Bool) {
        if (isFullVersion) {
            removeAdsButton.isEnabled = false
            removeAdsButton.isHidden = true
//            restoreButton.isEnabled = true
//            restoreButton.isHidden = false
        } else {
            removeAdsButton.isEnabled = true
            removeAdsButton.isHidden = false
//            restoreButton.isEnabled = false
//            restoreButton.isHidden = true
        }
    }
    
    fileprivate lazy var purchaseViewController: ProVersionPurchaseViewController = {
        let pvc = ProVersionPurchaseViewController()
        pvc.keyWindow = self.window
        return pvc
    }()
    
    fileprivate var prevSegmentIndex: Int = {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "LevelIndex")
    }()
    
    @objc fileprivate func restorePurchases() {
        IAPService.shared.restore()
    }
    
    @objc fileprivate func handlePurchase() {
        purchaseViewController.show()
    }
    
    @objc fileprivate func handleSegmentChange() {
        if segmentedControl.selectedSegmentIndex == 2 {
            // Advanced level is in pro version of app
            if (Purchases.fullVersion == false) {
                segmentedControl.selectedSegmentIndex = prevSegmentIndex
                purchaseViewController.show()
            } else {
                prevSegmentIndex = segmentedControl.selectedSegmentIndex
                let defaults = UserDefaults.standard
                defaults.set(segmentedControl.selectedSegmentIndex, forKey: "LevelIndex")
            }
        } else {
            prevSegmentIndex = segmentedControl.selectedSegmentIndex
            let defaults = UserDefaults.standard
            defaults.set(segmentedControl.selectedSegmentIndex, forKey: "LevelIndex")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
