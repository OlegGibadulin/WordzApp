import UIKit

class TodayCardView: UIView {
    
    var sentences: [Sentence]? {
        didSet {
            barsStackView.arrangedSubviews.forEach { (bsv) in
                barsStackView.removeArrangedSubview(bsv)
            }
            
            if let sentence = sentences!.first {
                // Sentence label
                sentenceLabel.text = sentence.text
                
                // Translation label
                var translations = ""
                sentence.translation?.forEach({ (translation) in
                     translations += translation + ", "
                })
                translations.remove(at: translations.index(before: translations.endIndex))
                translations.remove(at: translations.index(before: translations.endIndex))
                translationLabel.text = translations
                
                // Top bar
                (0..<sentences!.count).forEach { (_) in
                    let barView = UIView()
                    barView.backgroundColor = barDeselectedColor
                    barView.layer.cornerRadius = 2
                    barView.clipsToBounds = true
                    barsStackView.addArrangedSubview(barView)
                }
                barsStackView.arrangedSubviews.first?.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
                
                // Favorite button
                toFavouritesButton.isHidden = false
                toFavouritesButton.isSelected = sentence.isFavourite
            } else {
                // There are not more sentences for this level of todays cards
                toFavouritesButton.isHidden = true
                sentenceLabel.text = "Вы выучили все слова выбранного уровня сложности 🥳"
                translationLabel.text = ""
            }
        }
    }
    
    func updateFavoriteState() {
        if let sentences = sentences, sentences.count != 0 {
            let sentence = sentences[cardInd]
            toFavouritesButton.isSelected = sentence.isFavourite
        }
    }
    
    fileprivate let barsStackView: UIStackView = {
        let bsv = UIStackView()
        bsv.spacing = 4
        bsv.distribution = .fillEqually
        return bsv
    }()
    
    fileprivate let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont(name: "Nunito Sans SemiBold", size: 51)
        sl.font = UIFont.systemFont(ofSize: 51, weight: .medium)
        sl.textColor = UIColor.appColor(.purple)
        sl.textAlignment = .center
        sl.numberOfLines = 3
        sl.minimumScaleFactor = 0.7
        sl.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 0.7542273116)
        sl.layer.shadowRadius = 17
        sl.layer.shadowOpacity = 0.4
        sl.layer.shadowOffset = CGSize(width: 0, height: 3)
        sl.adjustsFontSizeToFitWidth = true
        return sl
    }()
    
    fileprivate let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont(name: "Nunito Sans SemiBold", size: 51)
        tl.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        tl.textColor = UIColor.appColor(.text_black_lightgray)
        tl.textAlignment = .center
        tl.numberOfLines = 5
        tl.minimumScaleFactor = 0.7
        tl.adjustsFontSizeToFitWidth = true
        return tl
    }()
    
    fileprivate let toFavouritesButton: UIButton = {
        let tfb = UIButton()
        if let empty = UIImage(named: "blueStarEmpty")?.withRenderingMode(.alwaysTemplate) {
            tfb.setImage(empty, for: .normal)
        }
        if let filled = UIImage(named: "blueStarFilled")?.withRenderingMode(.alwaysTemplate) {
            tfb.setImage(filled, for: .selected)
        }
        tfb.tintColor = UIColor.appColor(.buttonText_blue_white)
        tfb.translatesAutoresizingMaskIntoConstraints = false
        tfb.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tfb.widthAnchor.constraint(equalToConstant: 25).isActive = true
        tfb.addTarget(self, action: #selector(handleToFavourites), for: .touchUpInside)
        return tfb
    }()
    
    fileprivate let nextButton: UIButton = {
        let tfb = UIButton()
        tfb.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        tfb.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        tfb.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        tfb.setTitle("Next", for: .normal)
        tfb.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1)
        tfb.layer.cornerRadius = 10
        tfb.translatesAutoresizingMaskIntoConstraints = false
        tfb.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tfb.widthAnchor.constraint(equalToConstant: 107).isActive = true
        tfb.addTarget(self, action: #selector(handleNext(gesture:)), for: .touchUpInside)
        tfb.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        tfb.layer.shadowRadius = 5
        tfb.layer.shadowOpacity = 0.2
        tfb.layer.shadowOffset = CGSize(width: 0, height: 5)
        return tfb
    }()
    
    fileprivate let lastButton: UIButton = {
        let tfb = UIButton()
        tfb.setTitleColor(UIColor.appColor(.text_lightgray), for: .normal)
        tfb.setTitle("Last", for: .normal)
        tfb.translatesAutoresizingMaskIntoConstraints = false
        tfb.heightAnchor.constraint(equalToConstant: 15).isActive = true
        tfb.widthAnchor.constraint(equalToConstant: 53).isActive = true
        tfb.addTarget(self, action: #selector(handleLast(gesture:)), for: .touchUpInside)
        return tfb
    }()
    
    @objc fileprivate func handleToFavourites() {
        guard let sentences = sentences else { return }
        let sentence = sentences[cardInd]
        
        toFavouritesButton.isSelected = !toFavouritesButton.isSelected
        CoreDataManager.shared.favouriteSentence(sentence: sentence)
    }
    
    fileprivate let barDeselectedColor = UIColor.appColor(.text_darkgray_lightgray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setup() {
//        addSubview(barsStackView)
        addSubview(nextButton)
        addSubview(lastButton)
        addSubview(sentenceLabel)
        addSubview(translationLabel)
        addSubview(toFavouritesButton)
        
    }
    
    fileprivate func layout() {
        layer.cornerRadius = 23
        clipsToBounds = true
        backgroundColor = UIColor.appColor(.white_lightgray)
        //layoutBarsStackView()
        layoutNextLastButtons()
        layoutLabels()
        layoutFavouriteButton()
    }
    
    fileprivate func layoutNextLastButtons() {
        nextButton.bottomAnchor.constraint(equalTo: lastButton.bottomAnchor, constant: -33).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lastButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .todayCardHeight / (-15.86)).isActive = true
        lastButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func layoutBarsStackView() {
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 4))
    }
    
    fileprivate func layoutLabels() {
        sentenceLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: bounds.height / 4.75, left: 16, bottom: 0, right: 16))
        
        translationLabel.anchor(top: sentenceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 16, bottom: 0, right: 16))
    }
    
    fileprivate func layoutFavouriteButton() {
        toFavouritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        toFavouritesButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        
//        toFavouritesButton.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 5).isActive = true
    }
    
    fileprivate var cardInd = 0 {
        didSet {
            let sentence = sentences![cardInd]
            sentenceLabel.text = sentence.text
            
            var translations = ""
            sentence.translation?.forEach({ (translation) in
                 translations += translation + ", "
            })
            translations.remove(at: translations.index(before: translations.endIndex))
            translations.remove(at: translations.index(before: translations.endIndex))
            translationLabel.text = translations
            
            barsStackView.arrangedSubviews.forEach { (v) in
                v.backgroundColor = barDeselectedColor
            }
            barsStackView.arrangedSubviews[cardInd].backgroundColor = #colorLiteral(red: 0.368627451, green: 0.4196078431, blue: 0.9803921569, alpha: 1)
            
            toFavouritesButton.isSelected = sentence.isFavourite
        }
    }
    
    @objc fileprivate func handleNext(gesture: UITapGestureRecognizer) {
        superview?.subviews.forEach({ (subview) in
            subview.layer.removeAllAnimations()
        })
        
        let translation: CGFloat = 1000
        
        UIView.animate(withDuration: 0.1) {
            self.sentenceLabel.transform = CGAffineTransform(translationX: translation, y: 0)
            self.translationLabel.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        cardInd = (cardInd + 1) % sentences!.count
        self.sentenceLabel.transform = .identity
        self.translationLabel.transform = .identity
    }
    
    @objc fileprivate func handleLast(gesture: UITapGestureRecognizer) {
        superview?.subviews.forEach({ (subview) in
            subview.layer.removeAllAnimations()
        })
        
        let translation: CGFloat = -1000
        
        UIView.animate(withDuration: 0.1) {
            self.sentenceLabel.transform = CGAffineTransform(translationX: translation, y: 0)
            self.translationLabel.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        if cardInd == 0 {
            cardInd = sentences!.count - 1
        } else {
            cardInd -= 1
        }
        
        self.sentenceLabel.transform = .identity
        self.translationLabel.transform = .identity
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        superview?.subviews.forEach({ (subview) in
            subview.layer.removeAllAnimations()
        })
        
        let tapLocation = gesture.location(in: nil)
        let shouldGoToNextCard = tapLocation.x > frame.width / 2 ? true : false
        let translation: CGFloat = shouldGoToNextCard ? -1000 : 1000
        
        UIView.animate(withDuration: 0.1) {
            self.sentenceLabel.transform = CGAffineTransform(translationX: translation, y: 0)
            self.translationLabel.transform = CGAffineTransform(translationX: translation, y: 0)
            self.barsStackView.arrangedSubviews[self.cardInd].transform = CGAffineTransform(translationX: 0, y: -4)
        }
        
        self.barsStackView.arrangedSubviews[self.cardInd].transform = .identity
        
        if shouldGoToNextCard {
            cardInd = (cardInd + 1) % sentences!.count
        } else {
            if cardInd == 0 {
                cardInd = sentences!.count - 1
            } else {
                cardInd -= 1
            }
        }
        
        self.sentenceLabel.transform = .identity
        self.translationLabel.transform = .identity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
