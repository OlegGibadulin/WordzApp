import UIKit

class TodayCardsViewController: UIViewController {
    
    fileprivate var levelTitle: String {
        get {
            let defaults = UserDefaults.standard
            let levelIndex = defaults.integer(forKey: "LevelIndex")
            
            let levels = CoreDataManager.shared.fetchLevels()
            let levelsTitle = levels.compactMap { (level) -> String? in
                return level.title
            }
            return levelsTitle[levelIndex]
        }
    }
    
    fileprivate var prevLevelTitle: String!

    override func loadView() {
        self.view = TodayCardView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .todayCardHeight))
        
    }
    
    func view() -> TodayCardView {
        return self.view as! TodayCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodaySentences()
        
        setupInteractions()
    }
    
    func updateTodaySentences() {
        if levelTitle != prevLevelTitle {
            fetchTodaySentences()
        }
    }
    
    func setupInteractions() {
        let menuInteraction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(menuInteraction)
    }
    
    fileprivate func fetchTodaySentences() {
        prevLevelTitle = levelTitle
        
        // Fetch latest upload date of current level
        guard let level = CoreDataManager.shared.fetchLevel(title: levelTitle) else { return }
        guard let uploadDate = level.uploadDate else { return }
        
        // Fetch sentences from hidden category for current level
        guard let categoryForLevelTitle = Storage.shared.levelsTitle[levelTitle] else { return }
        guard let categoryForLevel = CoreDataManager.shared.fetchCategory(title: categoryForLevelTitle) else { return }
        var sentences = CoreDataManager.shared.fetchSentences(category: categoryForLevel)

        // Check for need to update
        if !Calendar.current.isDateInToday(uploadDate) {

            // Update upload date
            CoreDataManager.shared.updateDate(level: level)
            
            // Check if needed to upload new sentence from storage
            if CoreDataManager.shared.isNeedToUpdate(level: level) {
                // Upload sentences into CoreData level
                Storage.shared.uploadSentences(level: level)
            }

            // Get new set of sentences
            let newSentences = CoreDataManager.shared.fetchNotLearnedSentences(level: level)[randomPick: Storage.shared.everydaySentencesCount]
            
            // Delete sentences from hidden category for current level
            sentences.forEach { (sentence) in
                CoreDataManager.shared.deleteSentence(sentence: sentence)
            }
            // Add new sentences to hidden category for current level
            newSentences.forEach { (sentence) in
                guard let text = sentence.text, let translation = sentence.translation else { return }
                
                CoreDataManager.shared.addSentence(text: text, translation: translation, category: categoryForLevel)

                // Mark them isLearned
                CoreDataManager.shared.learnSentence(sentence: sentence)
            }
            sentences = newSentences
        }
        
        // Fetch sentences from today category
        guard let todayCategory = CoreDataManager.shared.fetchCategory(title: Storage.shared.todayCardsTitle) else { return }
        let categorySentences = CoreDataManager.shared.fetchSentences(category: todayCategory)
        
        // Check for need to update today category
        if categorySentences != sentences {
            // Delete sentences from today category
            categorySentences.forEach { (sentence) in
                CoreDataManager.shared.deleteSentence(sentence: sentence)
            }
            
            // Add sentences to today category
            sentences.forEach { (sentence) in
                guard let text = sentence.text, let translation = sentence.translation else { return }

                CoreDataManager.shared.addSentence(text: text, translation: translation, category: todayCategory)
            }
        }
        view().sentences = sentences
    }

}

extension TodayCardsViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (suggestedAction) -> UIMenu? in
//            let action1 = UIAction(title: "KeK") {(_) in
//                print("action")
//            }
            return UIMenu(title: "", children: [])
        }
    }
}
