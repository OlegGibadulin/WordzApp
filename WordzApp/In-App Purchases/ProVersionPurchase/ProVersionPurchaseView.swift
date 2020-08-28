//
//  ProVersionPurchaseView.swift
//  WordzApp
//
//  Created by Mac-HOME on 28.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

private let cellIdentifier = "BenefitCellId"

class ProVersionPurchaseView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let titleLabel: UILabel = {
        let tl = UILabel()
        let attributedText = NSMutableAttributedString(string: "WORDZ PRO", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light)])
        tl.attributedText = attributedText
        tl.textAlignment = .center
        return tl
    }()
    
    fileprivate let makePurchaseButton: UIButton = {
        let mpb = UIButton()
        mpb.backgroundColor = .darkGreen
        mpb.layer.cornerRadius = 10
        mpb.clipsToBounds = true
        
        let attributedTitle = NSMutableAttributedString(string: "Получить PRO Версию", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attributedTitle.append(NSMutableAttributedString(string: "\n199,00 ₽", attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        mpb.setAttributedTitle(attributedTitle, for: .normal)
        mpb.titleLabel?.numberOfLines = 2
        mpb.titleLabel?.textAlignment = .center
        
        mpb.translatesAutoresizingMaskIntoConstraints = false
        mpb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mpb.addTarget(self, action: #selector(handleMakePurchaseButtonTapped), for: .touchUpInside)
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
        backgroundColor = .white
        
        let overallStackView = UIStackView(arrangedSubviews: [titleLabel, benefitsTableView, makePurchaseButton])
        overallStackView.axis = .vertical
        overallStackView.distribution = .equalSpacing

        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 20, left: .sideMargin, bottom: 20, right: .sideMargin))
    }
    
    @objc fileprivate func handleMakePurchaseButtonTapped() {
        let purchacesViewController = PurchasesViewController()
        // TODO: I dont know which method I should call
        purchacesViewController.purchase(.ProVersion)
    }
    
    // MARK: - Benefits table
    
    fileprivate let benefitsTableView: UITableView = {
        let btv = UITableView()
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
        Benefit(title: "Собственные слова", description: "Добавляйте свои слова в Избранное и учите их по карточкам"),
        Benefit(title: "Доступ ко всем подборкам", description: "Учите те слова, которые вам точно пригодятся, с нашими тематическими подборками слов"),
        Benefit(title: "Продвинутый уровень", description: "Испытайте себя на самом сложном уровне \"Продвинутый\""),
        Benefit(title: "Тем более...", description: "Приобретая сейчас, вы получаете всю будущую функциональность PRO версии бесплатно"),
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
