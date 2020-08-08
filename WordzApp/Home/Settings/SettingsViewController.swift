//
//  SettingsViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 07.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var keyWindow: UIWindow? {
        didSet {
            guard let window = keyWindow else { return }
            
            settingsView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height * 2)
            blackoutView.frame = window.frame
            
            window.addSubview(blackoutView)
            window.addSubview(settingsView)
        }
    }
    
    fileprivate let height: CGFloat = 200
    
    fileprivate let settingsView = SettingsView()
    
    fileprivate let blackoutView: UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor(white: 0, alpha: 0.5)
        bv.alpha = 0
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func show() {
        guard let window = keyWindow else { return }
        
        let y = window.frame.height - height
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            self.blackoutView.alpha = 1
            self.settingsView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.settingsView.frame.height)
        }, completion: nil)
    }
    
    fileprivate func setupLayout() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        blackoutView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        settingsView.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handleTap() {
        guard let window = keyWindow else { return }
        
        UIView.animate(withDuration: 0.5) {
            self.blackoutView.alpha = 0
            self.settingsView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsView.frame.width, height: self.settingsView.frame.height)
        }
    }
    
    @objc fileprivate func handlePan(gesture: UITapGestureRecognizer) {
        // TODO:
    }
    
}
