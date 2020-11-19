import UIKit

class CategoryViewController: UIViewController {
    
    internal var transparentView: UIView!
    internal var popup: AddFavouriteWordView!
    
    let addButton : UIButton = {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        addButton.setBlueStyle()
        addButton.backgroundColor = .blue
        addButton.layer.cornerRadius = 8
        addButton.setImage(#imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.tintColor = .white
        addButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        return addButton
    }()
    
    var category: Category?
    
    internal lazy var categoryTableViewController: CategoryTableViewController = {
        let ctvc = CategoryTableViewController()
        ctvc.category = self.category
        ctvc.delegate = self
        return ctvc
    }()
    
    fileprivate var safeArea: UILayoutGuide!
    
    fileprivate lazy var tableView: UITableView = categoryTableViewController.tableView
    
    internal let toCardsButton: UIButton = {
        let tcb = UIButton(type: .system)
        tcb.setRedStyle()
        tcb.setTitleColor(.black, for: .highlighted)
        
        tcb.setTitle("Учить слова", for: .normal)
        tcb.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        tcb.tintColor = .white
        tcb.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tcb.addTarget(self, action: #selector(handleToCards), for: .touchUpInside)
        return tcb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        categoryTableViewController.tableView.reloadData()
    }
    
    @objc fileprivate func handleToCards() {
        print("\(StatisticCollector.swipesToLeft!) \(StatisticCollector.swipesToRight!) \(StatisticCollector.totalSwipes!)")
        let cardViewController = CardsViewController()
        cardViewController.category = category
        
        // Sentences taken from table view
        var sentencesInTableView = categoryTableViewController.sentences
        let sentencesInTableViewCount = sentencesInTableView.count
        
        // Variables to pass to Card View
        let countOfWords = CardsSettings.сardsInPack as Int
        let countOfRepeats = CardsSettings.сardsRepeats as Int
        var arrayOfSentences = [Sentence]()
        
        // Filter by sentences from table view by learned parameter
        sentencesInTableView = sentencesInTableView.filter({ (sentence) -> Bool in
            if sentence.learned < countOfRepeats {
                return true
            } else {
                return false
            }
        })
        
        // When count of words do not enough to equal User Defaults
        if (sentencesInTableView.count <= countOfWords) {
            sentencesInTableView.forEach { (sentence) in
                arrayOfSentences.append(sentence)
            }
        }
        // When enough count
        else {
            let categoryCount = sentencesInTableView.count
            for _ in 0..<countOfWords {
                while(true) {
                    let sentence = sentencesInTableView[Int.random(in: 0..<categoryCount)]
                    if arrayOfSentences.contains(sentence) == false {
                        arrayOfSentences.append(sentence)
                        break
                    }
                }
            }
        }
        
        if arrayOfSentences.count >= 5 {
            cardViewController.sentences = arrayOfSentences
            navigationController?.pushViewController(cardViewController, animated: true)
        } else {
            let title = navigationItem.title
            if title == Storage.shared.favouritesTitle && sentencesInTableViewCount < 5 {
                presentAlert(title: "Добавьте больше слов", text: "Вы не можете начать изучение избранных слов, если их количество меньше 5", additionalAction: nil)
            } else {
                let additionalAction = UIAlertAction(title: "Сбросить", style: .destructive) { (alert) in
                    CoreDataManager.shared.resetStatisticSentences(category: self.category) {
                        self.categoryTableViewController.tableView.reloadData()
                    }
                    print("Сброс статистики")
                }
                presentAlert(title: "Поздравляем!", text: "Вы выучили почти все слова из выбранной категории\n\nВы можете сбросить статистику, чтобы начать заново", additionalAction: additionalAction)
            }
        }
    }
    
    private func setupLayout() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = UIColor.appColor(.white_lightgray)
        
        view.addSubview(tableView)
        tableView.anchor(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(toCardsButton)
        toCardsButton.anchor(top: nil, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 33, bottom: 16, right: 33))
        
//        updateToCardsButton(isHidden: false)
        if categoryTableViewController.tableView.visibleCells.isEmpty {
            toCardsButton.alpha = 0
        }
    }
    
    internal func updateToCardsButton(isHidden: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.toCardsButton.alpha = isHidden ? 0 : 1
        }, completion: nil)
    }
    
    internal func checkEmptyTableView() {
        if (toCardsButton.alpha < 1 &&
            categoryTableViewController.tableView.visibleCells.count > 0) {
            updateToCardsButton(isHidden: false)
        }
    }
    
    // MARK: NavigationController
    
    fileprivate lazy var backButton: UIButton = {
        let bb = UIButton()
        bb.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        bb.setImage(UIImage(named: "leftArrowFatIcon"), for: .normal)
        bb.setBlueStyle()
        bb.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return bb
    }()
    
    fileprivate func setupNavigationController() {
        let title = category?.title
        navigationItem.title = title
        
        if title == Storage.shared.favouritesTitle {
            addButton.addTarget(self, action: #selector(AddWordTapped(sender:)), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc fileprivate func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func presentAlert(title: String, text: String, additionalAction: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        if let addAction = additionalAction {
            alert.addAction(addAction)
        }
        self.present(alert, animated: true)
    }
}
