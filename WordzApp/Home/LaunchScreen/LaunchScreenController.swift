import UIKit

class LaunchScreenController: UIViewController {
    
    fileprivate let launchScreenView = LaunchScreenView()
    
    var window: UIWindow? = {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        return window
    }()
    
    public func show() {
        guard let frame: CGRect = window?.frame else {return}
        launchScreenView.frame = frame
        window?.addSubview(launchScreenView)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.launchScreenView.alpha = 1
        }, completion: nil)
    }
    
    public func hide() {
        
        launchScreenView.isHidden = true
        guard let window = window else { return }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.launchScreenView.alpha = 0
        }, completion: { (_) in
            self.removeFromParent()
        })
        
    }
}
