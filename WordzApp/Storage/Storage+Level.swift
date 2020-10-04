import Foundation

struct LevelStorage {
    let title: String
    let sentences: [[String:[String]]]?
}

extension Storage {
    
    func uploadLevels() {
        levels.forEach { (level) in
            CoreDataManager.shared.addLevel(title: level.title)
        }
    }
    
    func deleteLevels() {
        let levels = CoreDataManager.shared.fetchLevels()
        levels.forEach { (level) in
            deleteSentences(level: level)
            CoreDataManager.shared.deleteLevel(level: level)
        }
    }
    
    func uploadSentences(level: Level?) {
        guard let level = level, let title = level.title else { return }
        
        let defaults = UserDefaults.standard
        let key = "CurrentSentenceNumberOf" + title
        let currentSentenceNumber = defaults.integer(forKey: key)
        
        // Search level storage by title
        let levelStorage = self.levels.filter { (levelStorage) -> Bool in
            return levelStorage.title == title
        }.first
        
        guard let uploadedLevel = levelStorage, let sentences = uploadedLevel.sentences else { return }
        
        // Check for not uploaded sentences in the storage
        if currentSentenceNumber < sentences.count {
            // Update current sentence number
            defaults.set(currentSentenceNumber + 1, forKey: key)
            
            // Get not uploaded sentences with a quantity of uploadingSentenceCount
            let sentencesToUpload = sentences[currentSentenceNumber]
            uploadSentences(level: level, sentences: sentencesToUpload)
        }
    }
    
}
