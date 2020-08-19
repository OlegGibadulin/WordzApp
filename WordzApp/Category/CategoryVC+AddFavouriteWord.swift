import UIKit

extension CategoryViewController: PopUpDelegate {
    @objc
    func AddWordTapped(sender: UIButton) {
        popupAddFavouriteView(sender: sender)
    }
    
    private func popupAddFavouriteView(sender: UIButton) {
        let window: UIWindow? = getMainWindow()
        
        transparentView = UIView()
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        transparentView.frame = self.view.frame
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnTranspaerntView))
        transparentView.addGestureRecognizer(tapGesture)
        
        popup = AddFavouriteWordView()
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.delegate = self
        
        
        
        window?.addSubview(transparentView)
        window?.addSubview(popup)
        
        setupAnchorsAddFavouriteView()
        
        setupAlpha(withAlpha: 0)
        animate(withDuration: 0.5, animations: {
            self.setupAlpha(withAlpha: 1)
        }, completion: nil)
    }
    
    private func setupAlpha(withAlpha: CGFloat) {
        transparentView.alpha = withAlpha
        popup.alpha = withAlpha
    }
    
    private func getMainWindow() -> UIWindow? {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    private func setupAnchorsAddFavouriteView() {
        popup.heightAnchor.constraint(equalToConstant: 270).isActive = true
        popup.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        popup.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        popup.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        transparentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        transparentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        transparentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    private func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: animations, completion: completion)
    }
    
    internal func handleDismissal() {
        animate(withDuration: 0.5, animations: {
            self.setupAlpha(withAlpha: 0)
        }) { (_) in
            self.transparentView.removeFromSuperview()
            self.popup.removeFromSuperview()
            self.categoryTableViewController.updateData()
            self.checkEmptyTableView()
        }
    }
    
    @objc
    func tapOnTranspaerntView() {
        handleDismissal()
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
