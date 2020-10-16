import UIKit
import SwiftyStoreKit
import StoreKit

private let cellIdentifier = "BenefitCellId"

class ProVersionPurchaseView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let titleLabel: UILabel = {
        let tl = UILabel()
        let attributedText = NSMutableAttributedString(string: "WORDZ FULL", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light)])
        tl.attributedText = attributedText
        tl.textAlignment = .center
        return tl
    }()
    
    fileprivate let makePurchaseButton: UIButton = {
        let mpb = UIButton()
        mpb.layer.cornerRadius = 10
        mpb.clipsToBounds = true
        
        let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let attributedTitle = NSMutableAttributedString(string: "Получить полную версию", attributes: [NSAttributedString.Key.foregroundColor: white, .font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attributedTitle.append(NSMutableAttributedString(string: "\n29,00 ₽", attributes: [NSAttributedString.Key.foregroundColor: white, .font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        
        let attributedTitleHighlited = NSMutableAttributedString(string: "Получить полную версию", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attributedTitleHighlited.append(NSMutableAttributedString(string: "\n29,00 ₽", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        
        mpb.setAttributedTitle(attributedTitle, for: .normal)
        mpb.setAttributedTitle(attributedTitleHighlited, for: .highlighted)
        mpb.titleLabel?.numberOfLines = 2
        mpb.titleLabel?.textAlignment = .center
        
        mpb.translatesAutoresizingMaskIntoConstraints = false
        mpb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mpb.addTarget(self, action: #selector(handleMakePurchaseButtonTapped), for: .touchUpInside)
        mpb.backgroundColor = .blue
        return mpb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        benefitsTableView.dataSource = self
        benefitsTableView.delegate = self
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor.appColor(.white_lightgray)
        
        let overallStackView = UIStackView(arrangedSubviews: [titleLabel, benefitsTableView, makePurchaseButton])
        overallStackView.axis = .vertical
        overallStackView.distribution = .equalSpacing

        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 20, left: .sideMargin, bottom: 20, right: .sideMargin))
    }
    
    let inAppPurchaseId = "com.Revolvetra.Wordz.RemoveAd"
    
    @objc fileprivate func handleMakePurchaseButtonTapped() {
        IAPService.shared.purchase(product: .removeAd)
        
    }
    
    // MARK: - Benefits table
    
    fileprivate let benefitsTableView: UITableView = {
        let btv = UITableView()
        btv.backgroundColor = UIColor.appColor(.white_lightgray)
        btv.register(BenefitsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        btv.tableFooterView = UIView()
        btv.allowsSelection = false
        btv.separatorStyle = .none
        btv.isScrollEnabled = false
        btv.translatesAutoresizingMaskIntoConstraints = false
        btv.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return btv
    }()
    
    fileprivate let benefits: [Benefit] = [
        Benefit(title: "Отключение рекламы", description: "Вам больше не будут высвечиваться рекламные предложения"),
        Benefit(title: "Продвинутый уровень", description: "Испытайте себя на самом сложном уровне \"Продвинутый\""),
        Benefit(title: "Обновления", description: "С новыми обновлениями для вас будут доступны все фишки полной версии приложения")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        benefits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BenefitsTableViewCell
        
        cell.benefit = benefits[indexPath.row]
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
//
//        cell.imageView?.image = #imageLiteral(resourceName: "benefits_check")
//        cell.textLabel?.text = benefits[indexPath.row].title
//
//        cell.detailTextLabel?.numberOfLines = 0
//        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
//        cell.detailTextLabel?.text = benefits[indexPath.row].description
        
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
