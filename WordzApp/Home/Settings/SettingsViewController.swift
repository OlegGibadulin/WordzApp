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
    
    var delegate: SettingsViewDelegate?
    
    fileprivate let height: CGFloat = 250
    
    fileprivate let settingsView = SettingsView()
    
    fileprivate let blackoutView: UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor(white: 0, alpha: 0.5)
        bv.alpha = 0
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPService.shared.getProducts()
        setupGestures()
    }
    
    func show() {
        self.settingsView.isHidden = false
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            self.blackoutView.alpha = 1
            self.setInitialPosition()
            
        }, completion: { (_) in
            self.blackoutView.isUserInteractionEnabled = true
        })
    }
    
    @objc fileprivate func hide() {
        guard let window = keyWindow else { return }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            self.blackoutView.alpha = 0
            self.settingsView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsView.frame.width, height: self.settingsView.frame.height)
            
        }, completion: { (_) in
            self.blackoutView.isUserInteractionEnabled = false
            self.settingsView.isHidden = true
        })
        delegate?.settingsViewWillDisappear()
    }
    
    fileprivate func setInitialPosition() {
        guard let window = keyWindow else { return }
        
        let y = window.frame.height - height
        self.settingsView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.settingsView.frame.height)
    }
    
    // MARK: - Gestures
    
    fileprivate func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        blackoutView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        settingsView.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let isDownDirection = translation.y > 0
        
        if isDownDirection {
            self.settingsView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }
        
        // Sometimes settingView magically move up by several dozen px
        // So this is a solution
        guard let window = keyWindow else { return }
        if settingsView.frame.minY < window.frame.height - height {
            setInitialPosition()
        }
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let shouldHide = translation.y > 50
        
        if shouldHide {
            hide()
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.setInitialPosition()
                
            }, completion: nil)
        }
    }
    
}
