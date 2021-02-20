import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "HomeCollectionViewCell"
    
    var category: Category! {
        didSet {
            titleLabel.text = category.title
            
            let firstColor = category?.firstColor as! UIColor
            let secondColor = category?.secondColor as! UIColor
            
            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
            gradientLayer.startPoint = .init(x: 0, y: 0.5)
            gradientLayer.endPoint = .init(x: 1, y: 0.5)
            gradientLayer.locations = [0, 1]
        }
    }
    
    let gradientLayer = CAGradientLayer()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tl.textAlignment = .center
        tl.textColor = .white
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayot()
    }
    
    fileprivate func setupLayot() {
        layer.cornerRadius = 5
        clipsToBounds = true
        
        layer.addSublayer(gradientLayer)
        
        addSubview(titleLabel)
        let titleBottomPadding = frame.height / 6
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: titleBottomPadding, right: 0))
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
