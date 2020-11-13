import UIKit

func toWordModel(sentence: Sentence) -> Word {
    guard let text = sentence.text, let translates = sentence.translation else  {
        return Word(word: "word", translate: ["слово"])
    }
    
    let word = Word(word: text, translate: translates)
    return word
}

final class CardView: UIView {
    static private let threshold: CGFloat = 50
    
    private var initialWidth: CGFloat = 0
    private var initialHeight: CGFloat = 0
    private var isOpen = true
    private var textLabel: UILabel!
    private var wordSelfCard: Word!
    private var sentence: Sentence!
    private var view: CardInteractionController!
    
    public var Sentence: Sentence {
        sentence
    }
    
    fileprivate var starButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .clear
        return sb
    }()
    
    fileprivate var isStarred: Bool = false
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialWidth = frame.width
        self.initialHeight = frame.height
        
        setupLayout()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(swipeGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOneTapPan(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(singleTapGesture)
    }
    
    required convenience init(frame: CGRect, sentence: Sentence, view: CardInteractionController) {
        self.init(frame: frame)
        
        self.sentence = sentence
        self.wordSelfCard = toWordModel(sentence: sentence)
        self.view = view
    }
    
    fileprivate func setupLayout() {
        backgroundColor = UIColor.appColor(.white_lightgray)
        self.layer.cornerRadius = 23
        self.clipsToBounds = false
        
    }
    
    private func setupStarButton() {
        changeStateButton(true)
        starButton.addTarget(self, action: #selector(handleStar(sender:)), for: .touchUpInside)
        self.addSubview(starButton)
        starButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        starButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        starButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        starButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
    
    public func setupLayerShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public func setupLabels() {
        textLabel = UILabel(frame: CGRect(x: 10, y: self.initialHeight / 3.5, width: self.initialWidth - 20, height: self.initialHeight / 2.5))
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 5
        textLabel.textColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.allowsDefaultTighteningForTruncation = true
        
        if wordSelfCard != nil {
            textLabel.text = self.wordSelfCard.word
        }
        
        textLabel.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        textLabel.layer.shadowRadius = 17
        textLabel.layer.shadowOpacity = 0.4
        textLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.addSubview(textLabel)
        setupStarButton()
    }
    
    @objc
    fileprivate func handleStar(sender: UIButton) {
        if isStarred {
            changeStateButton(isStarred)
        } else {
            changeStateButton(isStarred)
        }
        
        isStarred = isStarred ? false: true
    }
    
    private func changeStateButton(_ isFilled: Bool) {
        if isFilled {
            guard let emptyImage = UIImage(named: "blueStarEmpty") else { return }
            starButton.setImage(emptyImage, for: .normal)
            guard let filledImage = UIImage(named: "blueStarFilled") else { return }
            starButton.setImage(filledImage, for: [.highlighted])
        } else {
            guard let emptyImage = UIImage(named: "blueStarFilled") else { return }
            starButton.setImage(emptyImage, for: .normal)
            guard let filledImage = UIImage(named: "blueStarEmpty") else { return }
            starButton.setImage(filledImage, for: [.highlighted])
        }
    }
    
    @objc
    fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            view.enableSwipeButtons(isEnabled: false)
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
            view.enableSwipeButtons(isEnabled: true)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 15
        let angle = degrees * .pi / 180
        
        let rotationTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1: -1
        let shouldDismissedCard = abs(gesture.translation(in: nil).x) > CardView.threshold
        
        UIView.animate(withDuration: 0.4, delay: 0.01, usingSpringWithDamping: 10,
                       initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                        if shouldDismissedCard {
                            
                            if (self.view != nil && translationDirection > 0) {
                                self.view.updateSwipedCard(isFamilarWordSwiped: true)
                            } else if (self.view != nil && translationDirection <= 0) {
                                self.view.updateSwipedCard(isFamilarWordSwiped: false)
                            }
                            if self.isStarred {
                                if let text = self.sentence.text, let translate = self.sentence.translation {
                                    CoreDataManager.shared.addFavouriteSentence(text: text, translation: translate)
                                }
                            }
                            self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
                        } else {
                            self.transform = .identity
                        }
                       }, completion: { (_) in
                        self.transform = .identity
                        if shouldDismissedCard {
                            self.removeFromSuperview()
                        }
                       })
    }
    
    public func swipeCard(IfPositiveNumberThenSwipeRightElseLeft translationDirection: CGFloat) {
        if isStarred {
            if let text = sentence.text, let translate = sentence.translation {
                CoreDataManager.shared.addFavouriteSentence(text: text, translation: translate)
            }
        }
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                        self.frame = CGRect(x: 800 * translationDirection, y: 0, width: self.initialWidth, height: self.initialHeight)
                       }, completion: { (_) in
                        self.transform = .identity
                        self.removeFromSuperview()
                       })
    }
    
    @objc fileprivate func handleOneTapPan(gesture: UIPanGestureRecognizer) {
        showAnotherTranslation()
    }
    
    public func showAnotherTranslation() {
        if isOpen {
            isOpen = false
            
            textLabel.text = wordSelfCard.toStringTranslate
            //            textLabel.text = wordSelfCard.translate
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        } else {
            isOpen = true
            textLabel.text = wordSelfCard.word
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
