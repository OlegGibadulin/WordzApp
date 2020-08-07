//
//  SettingsViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

//extension UIWindow {
//    static var key: UIWindow? {
//        if #available(iOS 13, *) {
//            return UIApplication.shared.windows.first { $0.isKeyWindow }
//        } else {
//            return UIApplication.shared.keyWindow
//        }
//    }
//}

class SettingsViewController: UIViewController {
    
//    var keyWindow: UIWindow? {
//        didSet {
//            guard let window = keyWindow else { return }
//
//            view.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height * 2)
//            blackoutView.frame = window.frame
//
//            window.addSubview(blackoutView)
//            window.addSubview(self.view)
//        }
//    }
//
//    fileprivate let height: CGFloat = 200
//
////    fileprivate let collectionView: UICollectionView = {
////        let layout = UICollectionViewLayout()
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        return cv
////    }()
//
//    fileprivate let
//
//    fileprivate let blackoutView: UIView = {
//        let bv = UIView()
//        bv.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        return bv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setupLayout()
//    }
//
//    func show() {
//        guard let window = keyWindow else { return }
//
//        let y = window.frame.height - height
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
//
//            self.blackoutView.alpha = 1
//            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
//        }, completion: nil)
//    }
//
////    fileprivate func setupLayout() {
////        layer.cornerRadius = 23
////        clipsToBounds = true
////        backgroundColor = .darkBlue
////
////        addSubview(collectionView)
////        collectionView.fillSuperview(padding: .init(top: 30, left: 0, bottom: 0, right: 0))
////
////        blackoutView.alpha = 0
////
////        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
////        blackoutView.addGestureRecognizer(tapGesture)
////
////        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
////        self.addGestureRecognizer(panGesture)
////    }
//
//    @objc fileprivate func handleDismiss() {
//        guard let window = keyWindow else { return }
//
//        UIView.animate(withDuration: 0.5) {
//            self.blackoutView.alpha = 0
//            self.view.frame = CGRect(x: 0, y: window.frame.height, width: self.view.frame.width, height: self.view.frame.height)
//        }
//    }
//
//    @objc fileprivate func handlePan(gesture: UITapGestureRecognizer) {
//        // TODO:
//    }
    
}
