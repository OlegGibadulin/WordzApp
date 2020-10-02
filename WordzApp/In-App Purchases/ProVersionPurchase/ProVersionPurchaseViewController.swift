//
//  ProVersionPurchaseViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 28.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class ProVersionPurchaseViewController: UIViewController {
    
    var keyWindow: UIWindow? {
        didSet {
            guard let window = keyWindow else { return }
            
            let width = window.frame.width - 2 * x
            let height = window.frame.height - 5 * y
            purchaseView.frame = CGRect(x: x, y: y, width: width, height: height)
            blackoutView.frame = window.frame
            
            window.addSubview(blackoutView)
            window.addSubview(purchaseView)
            setupGestures()
        }
    }
    
    fileprivate let x: CGFloat = .sideMargin
    fileprivate let y: CGFloat = 50
    fileprivate let purchaseView = ProVersionPurchaseView()
    
    fileprivate let blackoutView: UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor(white: 0, alpha: 0.5)
        bv.alpha = 0
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPService.shared.getProducts()
        print(UserDefaults.standard.bool(forKey: "isFullVersion"))
        print()
    }
    
    func show() {
        UIView.animate(withDuration: 0.1) {
            self.blackoutView.alpha = 1
            // top to bottom
            self.purchaseView.frame = CGRect(x: self.x, y: self.view.frame.height/2 - self.purchaseView.frame.height/2, width: self.purchaseView.frame.width, height: self.purchaseView.frame.height)
        }
    }
    
    @objc fileprivate func hide() {
        UIView.animate(withDuration: 0.1) {
            self.blackoutView.alpha = 0
            // bottom to top
            self.purchaseView.frame = CGRect(x: self.x, y: -self.purchaseView.frame.height, width: self.purchaseView.frame.width, height: self.purchaseView.frame.height)
        }
    }
    
    fileprivate func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        blackoutView.addGestureRecognizer(tapGesture)
    }

}
