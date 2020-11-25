import UIKit

final class CardResultView: UIView {
    private var firstLineStackView: UIStackView!
    private var secondLineStackView: UIStackView!
    private var thirdLineStackView: UIStackView!
    private var overallStackView: UIStackView!
    private var tmp1StackView: UIStackView!
    private var tmp2StackView: UIStackView!
    private var tmp3StackView: UIStackView!
    private var tmp4StackView: UIStackView!
    
    private var initialWidth: CGFloat = 0
    private var initialHeight: CGFloat = 0
    
    private var textLabel: UILabel!
    private var familarLabel: UILabel!
    private var unfamilarLabel: UILabel!
    private var separatorLabel : UILabel!
    
    private var view: CardInteractionController!
    
    
    public var finishButton : UIButton!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialWidth = frame.width
        self.initialHeight = frame.height
        
        setupLayout()
        setupFirstLine()
        setupSecondLine()
        setupThirdLine()
        setupOverallStackView()
        setupAnchors()
        
//        self.isHidden = true
    }
    
    public func SetHideMode(isHidden: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.isHidden = isHidden
        }, completion: nil)
    }
    
    required convenience init(frame: CGRect, view: CardInteractionController) {
        self.init(frame: frame)
        self.view = view
    }
    
    fileprivate func setupLayout() {
        backgroundColor = UIColor.appColor(.white_lightgray)
        self.layer.cornerRadius = 23
//        self.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 23)
    }
    
    public func setupLayerShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    @objc
    func backButtonTapped() {
        if self.view != nil {
            self.view.returnBack()
        }
    }
    
    public func updateLabel(message: (unfamilarWords: Int, familarWords: Int)) {
        //ᐊᐅ
        unfamilarLabel.text = "\(message.unfamilarWords)"
        familarLabel.text = "\(message.familarWords)"
    }
    
    func setupFirstLine() {
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.textColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        textLabel.allowsDefaultTighteningForTruncation = true
        
        textLabel.text = "Результат"
        textLabel.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        textLabel.layer.shadowRadius = 17
        textLabel.layer.shadowOpacity = 0.4
        textLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        firstLineStackView = UIStackView(arrangedSubviews: [textLabel])
        
        firstLineStackView.axis = .horizontal
        firstLineStackView.distribution = .fill
        firstLineStackView.spacing = 0
    }
    
    func setupSecondLine() {
        unfamilarLabel = UILabel()
        unfamilarLabel.text = "0"
        unfamilarLabel.textAlignment = .right
        unfamilarLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        unfamilarLabel.textColor = UIColor.appColor(.red)
        unfamilarLabel.layer.shadowColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.7484749572)
        unfamilarLabel.layer.shadowRadius = 17
        unfamilarLabel.layer.shadowOpacity = 0.4
        unfamilarLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        separatorLabel = UILabel()
        separatorLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        separatorLabel.textAlignment = .center
        separatorLabel.numberOfLines = 2
        separatorLabel.textColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        separatorLabel.text = "/"
        separatorLabel.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        separatorLabel.layer.shadowRadius = 17
        separatorLabel.layer.shadowOpacity = 0.4
        separatorLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        familarLabel = UILabel()
        familarLabel.text = "0"
        familarLabel.textAlignment = .left
        familarLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        familarLabel.textColor = UIColor.appColor(.green)
        familarLabel.layer.shadowColor = #colorLiteral(red: 0.2941176471, green: 0.6235294342, blue: 0.1686274558, alpha: 0.75)
        familarLabel.layer.shadowRadius = 17
        familarLabel.layer.shadowOpacity = 0.4
        familarLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        tmp1StackView = UIStackView(arrangedSubviews: [UIView()])
        tmp2StackView = UIStackView(arrangedSubviews: [UIView()])
        
        secondLineStackView = UIStackView(arrangedSubviews: [tmp1StackView, unfamilarLabel, separatorLabel, familarLabel, tmp2StackView])
        
        secondLineStackView.axis = .horizontal
        secondLineStackView.distribution = .fill
        secondLineStackView.spacing = 5
    }
    
    func setupThirdLine() {
        finishButton = UIButton()
        finishButton.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        finishButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        finishButton.setTitleColor(UIColor.appColor(.white_lightgray), for: .normal)
        finishButton.setTitleColor(#colorLiteral(red: 0.2548029721, green: 0.2934122682, blue: 0.6900398135, alpha: 1), for: .highlighted)
        finishButton.setTitle("Завершить", for: .normal)
        finishButton.layer.cornerRadius = 10
        finishButton.clipsToBounds = true
        
        tmp3StackView = UIStackView(arrangedSubviews: [UIView()])
        tmp4StackView = UIStackView(arrangedSubviews: [UIView()])
        
        thirdLineStackView = UIStackView(arrangedSubviews: [tmp3StackView, finishButton, tmp4StackView])
        
        secondLineStackView.axis = .horizontal
        secondLineStackView.distribution = .fill
        secondLineStackView.spacing = 5
    }
    
    func setupOverallStackView() {
        let sv1 = UIStackView(arrangedSubviews: [UIView()])
        let sv2 = UIStackView(arrangedSubviews: [UIView()])
        
        overallStackView = UIStackView(arrangedSubviews: [sv1, firstLineStackView , secondLineStackView, thirdLineStackView, sv2])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 5
        
        self.addSubview(overallStackView)
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        sv2.heightAnchor.constraint(equalTo: sv1.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setupAnchors() {
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLineStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdLineStackView.translatesAutoresizingMaskIntoConstraints = false
        
        unfamilarLabel.translatesAutoresizingMaskIntoConstraints = false
        familarLabel.translatesAutoresizingMaskIntoConstraints = false
        unfamilarLabel.rightAnchor.constraint(equalTo: separatorLabel.leftAnchor, constant: 0).isActive = true
        familarLabel.leftAnchor.constraint(equalTo: separatorLabel.rightAnchor, constant: 0).isActive = true
        
        firstLineStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        secondLineStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        thirdLineStackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        thirdLineStackView.topAnchor.constraint(equalTo: secondLineStackView.bottomAnchor, constant: 20).isActive = true
        unfamilarLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        familarLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        finishButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        tmp2StackView.widthAnchor.constraint(equalTo: tmp1StackView.widthAnchor, multiplier: 1).isActive = true
        tmp4StackView.widthAnchor.constraint(equalTo: tmp3StackView.widthAnchor, multiplier: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
