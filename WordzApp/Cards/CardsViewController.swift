import UIKit

protocol CardInteractionController: class {
    func enableSwipeButtons(isEnabled enabled: Bool)
    func updateSwipedCard(isFamilarWordSwiped: Bool)
    func returnBack()
}

final class CardsViewController: UIViewController {
    // MARK:- Outlets
    public var category: Category?
    
    public var sentences = [Sentence]()
    public var learnedSentences = [Sentence]()
    
    private var tmp1StackView: UIStackView!
    private var cardContentStackView: UIStackView!
    private var cardButtonsStackView: UIStackView!
    private var cardsStackView: UIStackView!
    private var tmp2StackView: UIStackView!
    private var overallStackView: UIStackView!
    
    private let backButton: UIButton = {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        backButton.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        backButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        backButton.layer.cornerRadius = 8
        backButton.layer.shadowColor = UIColor.appColor(.buttonShadow_purple_darkpurple)?.cgColor
        backButton.layer.shadowRadius = 3
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        return backButton
    }()
    
    private let settingsButton: UIButton = {
        let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 33))
        settingsButton.setImage(UIImage(named: "threePointsIcon"), for: .normal)
        settingsButton.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0, blue: 1, alpha: 1)
        settingsButton.layer.cornerRadius = 8
        settingsButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        settingsButton.layer.shadowRadius = 3
        settingsButton.layer.shadowOpacity = 0.5
        settingsButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return settingsButton
    }()
    
    private let swipeLeftButton: UIButton = {
        let swipeLeftButton = UIButton()
        swipeLeftButton.roundCorners([.layerMinXMaxYCorner], radius: 23)
        swipeLeftButton.setTitle("Я не знаю\nэто слово", for: .normal)
        swipeLeftButton.titleLabel?.numberOfLines = 2
        swipeLeftButton.setTitleColor(#colorLiteral(red: 0.006038194057, green: 0.06411762536, blue: 0.6732754707, alpha: 1), for: .highlighted)
        swipeLeftButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.09411764706, blue: 1, alpha: 1)
        
        swipeLeftButton.clipsToBounds = false
        swipeLeftButton.translatesAutoresizingMaskIntoConstraints = false
        swipeLeftButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        swipeLeftButton.layer.shadowRadius = 5
        swipeLeftButton.layer.shadowOpacity = 0.2
        swipeLeftButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        return swipeLeftButton
    }()
    
    private let swipeRightButton: UIButton = {
        let swipeRightButton = UIButton()
        swipeRightButton.roundCorners([.layerMaxXMaxYCorner], radius: 23)
        swipeRightButton.setTitle("Я знаю\nэто слово", for: .normal)
        swipeRightButton.titleLabel?.numberOfLines = 2
        swipeRightButton.setTitleColor(UIColor.appColor(.buttonText_blue_white), for: .normal)
        swipeRightButton.setTitleColor(#colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1), for: .highlighted)
        swipeRightButton.backgroundColor = UIColor.appColor(.button_white_lightgray)
        swipeRightButton.clipsToBounds = false
        swipeRightButton.translatesAutoresizingMaskIntoConstraints = false
        swipeRightButton.layer.shadowColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.9764705882, alpha: 1)
        swipeRightButton.layer.shadowRadius = 5
        swipeRightButton.layer.shadowOpacity = 0.2
        swipeRightButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        return swipeRightButton
    }()
    
    private var circle1 : UIView!
    private var loadingView: CardLoadingView!
    
    private var result = (unfamilarWords: 0, familarWords: 0)
    
    private var cardsView = [CardView]()
    private var oneCardView: CardResultView!
    
    public var words = [Word]()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performActionWithLoadingView(isNeedToShow: true)
        
        setupLayout()
        setupNavigationBar()
        setupStackViews()
    }
    
    //MARK:- viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fillCards()
    }
    
    //MARK:- Fill Cards Logic
    private func fillCards() {
        let frame = cardContentStackView.frame
        
        oneCardView = CardResultView(frame: frame, view: self)
        cardContentStackView.addSubview(oneCardView)
        oneCardView.finishButton.isEnabled = false
        
        for i in 0..<sentences.count-1 {
            let number1 = Int.random(in: 0..<sentences.count-1)
            let tmp = sentences[i]
            sentences[i] = sentences[number1]
            sentences[number1] = tmp
        }
        
        sentences.forEach { (sentence) in
            let cardView = CardView(frame: frame, sentence: sentence, view: self)
            cardView.setupLabels()
            cardView.isHidden = true
            self.cardsView.append(cardView)
            cardView.isUserInteractionEnabled = false
            cardContentStackView.addSubview(cardView)
        }
        
        if cardsView.count > 2 {
            cardsView[cardsView.count - 1].isHidden = false
            cardsView[cardsView.count - 2].isHidden = false
            cardsView.last?.isUserInteractionEnabled = true
        }
        
        performActionWithLoadingView(isNeedToShow: false)
    }
    
    //MARK:- Fetch Sentences
    public func fetchSentences() -> [Sentence] {
        let sentences = CoreDataManager.shared.fetchNotLearnedSentences(category: category)
        let shuffledSentences = sentences[randomPick: CardsSettings.сardsInPack as Int]
        return shuffledSentences
    }
    
    // MARK:- LoadingView control method
    private func performActionWithLoadingView(isNeedToShow state: Bool) {
        if (state == true) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            loadingView = CardLoadingView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            window?.addSubview(loadingView)
        } else {
            loadingView.stopLoading()
            let duration: Int = 1
            UIView.animate(withDuration: Double(duration) / 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.loadingView.alpha = 0
                let queue = DispatchQueue.global()
                queue.asyncAfter(deadline: .now() + .seconds(Int(duration))) {
                    DispatchQueue.main.async {
                        self.loadingView.removeFromSuperview()
                        self.loadingView = nil
                    }
                }
            }, completion: nil)
        }
    }
    
    // MARK:- Setups
    private func setupLayout() {
        self.view.backgroundColor = UIColor.appColor(.lightyellow_darkgray)
        setupDesign()
    }
    
    private func setupDesign() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let circle1Height = CGFloat(height / 2.5)
        
        self.circle1 = UIView(frame: CGRect(x: (-1 ) * circle1Height / 1.8, y: height * (1/5), width: circle1Height, height: circle1Height))
        circle1.layer.cornerRadius = circle1Height / 2
        circle1.clipsToBounds = true
        circle1.backgroundColor = #colorLiteral(red: 0, green: 0.08235294118, blue: 1, alpha: 1)
        
        let circle2Height = CGFloat(height / 3.5)
        
        let circle2 = UIView(frame: CGRect(x: width * 0.552, y: (-1) * circle2Height / 5, width: circle2Height, height: circle2Height))
        circle2.layer.cornerRadius = circle2Height / 2
        circle2.clipsToBounds = true
        circle2.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.7607843137, alpha: 1)
        
        let circle3Height = CGFloat(height / 2.9)
        
        let circle3 = UIView(frame: CGRect(x: width * (2.5 / 3.5), y: height * (0.4), width: circle3Height, height: circle3Height))
        circle3.layer.cornerRadius = circle3Height / 2
        circle3.clipsToBounds = true
        circle3.backgroundColor = #colorLiteral(red: 0, green: 0.8196078431, blue: 1, alpha: 1)
        
        self.view.addSubview(circle1)
        self.view.addSubview(circle2)
        self.view.addSubview(circle3)
    }
    
    private func setupStackViews() {
        setupMoveCardButtons()
        setupDummyCards()
        setupOverallStackView()
        setupAnchors()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupDummyCards() {
        let tmpCardResultView = CardResultView()
        tmpCardResultView.fillSuperview()
        tmpCardResultView.translatesAutoresizingMaskIntoConstraints = false
        cardContentStackView = UIStackView(arrangedSubviews: [tmpCardResultView])
        cardContentStackView.axis = .vertical
    }
    
    private func setupMoveCardButtons() {
        swipeLeftButton.addTarget(self, action: #selector(swipeLeft), for: .touchUpInside)
        swipeRightButton.addTarget(self, action: #selector(swipeRight), for: .touchUpInside)
        
        cardButtonsStackView = UIStackView(arrangedSubviews: [swipeLeftButton, swipeRightButton])
        
        cardButtonsStackView.axis = .horizontal
        cardButtonsStackView.distribution = .fillProportionally
        cardButtonsStackView.spacing = 0
    }
    
    private func setupOverallStackView() {
        tmp1StackView = UIStackView(arrangedSubviews: [UIView()])
        tmp2StackView = UIStackView(arrangedSubviews: [UIView()])
        
        cardsStackView = UIStackView(arrangedSubviews: [cardContentStackView, cardButtonsStackView])
        cardsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardsStackView.axis = .vertical
        
        overallStackView = UIStackView(arrangedSubviews: [tmp1StackView, cardsStackView, tmp2StackView])
        overallStackView.spacing = 0
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        
        self.view.addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    private func setupAnchors() {
        tmp1StackView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        cardContentStackView.heightAnchor.constraint(equalToConstant: 460).isActive = true
        cardButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardButtonsStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        if cardButtonsStackView.arrangedSubviews.count > 1 {
            cardButtonsStackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: cardButtonsStackView.arrangedSubviews[0].widthAnchor, multiplier: 1).isActive = true
        }
        
        tmp2StackView.heightAnchor.constraint(equalTo: tmp1StackView.heightAnchor, multiplier: 1.35).isActive = true
        cardsStackView.bringSubviewToFront(cardContentStackView)
    }
    
    // MARK:- Selectors
    @objc
    private func backButtonTapped(sender: UIButton) {
        returnBack()
    }
    
    @objc internal func swipeLeft() {
        if let card = cardsView.last {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: -1)
            updateSwipedCard(isFamilarWordSwiped: false)
        }
    }
    
    @objc internal func swipeRight() {
        if let card = cardsView.last {
            card.swipeCard(IfPositiveNumberThenSwipeRightElseLeft: 1)
            updateSwipedCard(isFamilarWordSwiped: true)
        }
    }
    
    fileprivate lazy var settingsViewController: CardSettingsViewController = {
        let svc = CardSettingsViewController()
        svc.category = category
        svc.keyWindow = self.view.window
        return svc
    }()
    
    @objc fileprivate func settingsButtonTapped(sender: UIButton) {
        settingsViewController.show()
    }
    private let screenSize = UIScreen.main.bounds.size
}


// MARK:- CardInteractionController Protocol Realization
extension CardsViewController: CardInteractionController {
    internal func enableSwipeButtons(isEnabled enabled: Bool) {
        backButton.isEnabled = enabled
        settingsButton.isEnabled = enabled
        swipeLeftButton.isEnabled = enabled
        swipeRightButton.isEnabled = enabled
    }
    
    internal func updateSwipedCard(isFamilarWordSwiped: Bool) {
        
        
        if cardsView.count > 0 {
            cardsView[cardsView.count - 1].isHidden = false
        }
        
        if cardsView.count > 1 {
            cardsView[cardsView.count - 2].isHidden = false
        }
        
        if cardsView.count > 2 {
            cardsView[cardsView.count - 3].isHidden = false
        }
        
        let card = cardsView.popLast()
        
        if isFamilarWordSwiped == true {
            result.familarWords += 1
            if let card = card {
                learnedSentences.append(card.Sentence)
            }
        } else {
            result.unfamilarWords += 1
        }
        
        if cardsView.count < 1 {
            oneCardView.finishButton.isEnabled = true
            CoreDataManager.shared.learnSentences(sentences: learnedSentences)
            print(learnedSentences)
        }
        
        cardsView.last?.isUserInteractionEnabled = true
        
        
        oneCardView.updateLabel(message: result)
    }
    
    internal func returnBack() {
        circle1.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
}
