import Foundation

extension Storage {
    
    func uploadSentences(level: Level?, sentences: [String:[String]]?) {
        guard let level = level, let sentences = sentences else { return }
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.addSentence(text: sentence.key, translation: sentence.value, level: level)
        }
    }
    
    func uploadSentences(category: Category?, sentences: [String:[String]]?) {
        guard let category = category, let sentences = sentences else { return }
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.addSentence(text: sentence.key, translation: sentence.value, category: category)
        }
    }
    
    func deleteSentences(level: Level) {
        let sentences = CoreDataManager.shared.fetchSentences(level: level)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
    func deleteSentences(category: Category) {
        let sentences = CoreDataManager.shared.fetchSentences(category: category)
        
        sentences.forEach { (sentence) in
            CoreDataManager.shared.deleteSentence(sentence: sentence)
        }
    }
    
}
