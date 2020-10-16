import UIKit
import CoreData

private let cellIdentifier = "CategoryCellId"

class CategoryTableViewController: UITableViewController {
    
    var category: Category?
    var delegate: PopUpDelegate?
    
    public var sentences = [Sentence]()
    
    private var emptyView = EmptyView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        startActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.fetchSentences()
            self.stopActivityIndicator()
            self.tableView.reloadData()
//            self.setupEmptyState()
//            self.reloadEmptyState()
            self.setupEmptyView()
            self.checkIsEmpty()
            self.delegate?.updateToCardsButton()
        }
        
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func updateData() {
        fetchSentences()
        self.tableView.reloadData()
        checkIsEmpty()
    }
    
    func setupEmptyView() {
        emptyView.frame = view.bounds
        self.view.addSubview(emptyView)
    }
    
    func checkIsEmpty() {
        if (sentences.count < 1) {
            showEmptyView(isNeedToShow: true)
        } else {
            showEmptyView(isNeedToShow: false)
        }
    }
    
    func showEmptyView(isNeedToShow: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if (isNeedToShow == true) {
                self.emptyView.alpha = 1
            } else {
                self.emptyView.alpha = 0
            }
        }) { (_) in
            if (isNeedToShow == true) {
                self.emptyView.isHidden = false
            } else {
                self.emptyView.isHidden = true
            }
            self.emptyView.playAnimation()
        }
    }
    
    fileprivate func fetchSentences() {
        guard let title = category?.title else { return }
        
        // Check for upload into CoreData
        if title != Storage.shared.favouritesTitle && CoreDataManager.shared.isEmpty(category: category) {
            Storage.shared.uploadSentences(category: category)
        }
        
        sentences = CoreDataManager.shared.fetchSentences(category: category)
        
        if title == Storage.shared.favouritesTitle {
            sentences.reverse()
            return
        }
    }
    
    fileprivate func setupLayout() {
        tableView.backgroundColor = UIColor.appColor(.white_lightgray)
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.white_lightgray)
        tableView.tableFooterView = view
        tableView.allowsSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        
        cell.textLabel?.textColor = UIColor.appColor(.text_black_white)
        cell.backgroundColor = UIColor.appColor(.white_lightgray)
        cell.sentence = sentences[indexPath.row]
        if (sentences[indexPath.row].learned >= CardsSettings.сardsRepeats) {
            cell.showImage(isNeedToShow: true)
        } else {
            cell.showImage(isNeedToShow: false)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let title = category?.title, title == Storage.shared.favouritesTitle else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, complete) in
            
            let sentence = self.sentences[indexPath.row]
            
            // delete from tableview
            self.sentences.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // delete from CoreData
            CoreDataManager.shared.deleteFavoriteSentence(sentence: sentence)
            
            self.checkIsEmpty()
//            self.reloadEmptyState()
            complete(true)
        }
        deleteAction.backgroundColor = .lightRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    // MARK: - Activity indicator
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        ai.style = .large
        ai.center = self.view.center
        ai.backgroundColor = .white
        ai.hidesWhenStopped = true
        return ai
    }()
    
    fileprivate lazy var loadingView: UIView = {
        let lv = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        lv.center = self.view.center
        lv.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        lv.layer.cornerRadius = 10
        lv.clipsToBounds = true
        return lv
    }()
    
    fileprivate func startActivityIndicator() {
        view.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    fileprivate func stopActivityIndicator() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
}
