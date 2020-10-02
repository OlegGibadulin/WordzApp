import UIKit
import Lottie


class EmptyView: UIView {

    // MARK:- Properties
    private var animationView: AnimationView!
    private var label = UILabel()
    
    // MARK:- Setup
    func setup() {
        setupAnimation()
        setupLabel()
    }
    
    func setupLabel() {
        label.text = "Здесь пока пусто"
        label.textColor = UIColor.appColor(.text_black_white)
        label.font = label.font.withSize(20)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAnimation() {
        animationView = .init(name: "empty")
        
        animationView.backgroundColor = UIColor.appColor(.white_lightgray)
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
        animationView.contentMode = .scaleAspectFit
        
        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        layoutAnimation()
        layoutLabel()
    }
    
    func layoutAnimation() {
        let y = self.frame.maxY / 3.5
        
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.topAnchor, constant: y).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        animationView.play()
    }
    
    func layoutLabel() {
        label.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    // MARK:- Methods
    func playAnimation() {
        animationView.play()
    }
}
