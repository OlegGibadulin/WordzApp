//
//  Word.swift
//  WordzApp
//
//  Created by Антон Тимонин on 08.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

struct Word: Equatable {
    let word: String
    let translate: [String]
    
    
//    func toStringTranslate() -> String
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


