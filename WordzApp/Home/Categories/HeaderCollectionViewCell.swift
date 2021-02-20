import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    public static let identifier = "HeaderCollectionViewCell"
    
    public var todayView: UIView!
    
    fileprivate let wordzLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "wordz_gray"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    fileprivate let cardzLogoView: UIImageView = {
        let lv = UIImageView(image: #imageLiteral(resourceName: "cardz_orange"))
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.contentMode = .scaleAspectFill
        return lv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setup(todayView: UIView) {
        self.todayView = todayView
        todayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wordzLogoView)
        contentView.addSubview(todayView)
        addSubview(cardzLogoView)
        
        wordzLogoView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: nil, trailing: nil,
                             padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                             size: .init(width: 120, height: 30))

//        todayView.anchor(top: wordzLogoView.bottomAnchor,
//                             leading: leadingAnchor,
//                             bottom: nil,
//                             trailing: trailingAnchor,
//                             padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
//                             size: .init(width: UIScreen.main.bounds.width - 42, height: 345))
        
        todayView.topAnchor.constraint(equalTo: wordzLogoView.bottomAnchor, constant: 20).isActive = true
        todayView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        todayView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 42).isActive = true
        todayView.heightAnchor.constraint(equalToConstant: 345).isActive = true

        cardzLogoView.anchor(top: todayView.bottomAnchor,
                             leading: leadingAnchor,
                             bottom: nil, trailing: nil,
                             padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0),
                             size: .init(width: 120, height: 30))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
