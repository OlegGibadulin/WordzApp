import UIKit

public extension UIAlertController {
    func withAction(_ action: UIAlertAction) -> Self {
        addAction(action)
        return self
    }
}
