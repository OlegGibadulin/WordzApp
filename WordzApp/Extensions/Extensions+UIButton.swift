import UIKit

extension UIButton {
    func setBlueStyle() {
        backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        layer.cornerRadius = 8
        layer.shadowColor = #colorLiteral(red: 0.1254901961, green: 0.1450980392, blue: 0.3450980392, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func setRedStyle() {
        backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.262745098, blue: 0.3215686275, alpha: 1)
        layer.cornerRadius = 8
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.5
        setBackgroundColor(#colorLiteral(red: 0.7832607627, green: 0.2143747509, blue: 0.2649599314, alpha: 1), for: .highlighted)
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}
