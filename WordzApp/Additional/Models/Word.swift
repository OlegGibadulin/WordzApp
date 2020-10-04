import Foundation

struct Word: Equatable {
    let word: String
    let translate: [String]
    
    var toStringTranslate: String {
        get {
            var text = ""
            let count = translate.count
            for i in 0..<count {
                text += translate[i]
                if (i != count - 1) {
                    text += "\n"
                }
            }
            return text
        }
    }
    
    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word && lhs.toStringTranslate == rhs.toStringTranslate
    }
}


