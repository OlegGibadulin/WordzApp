//
//  CategoryTableViewCell.swift
//  WordzApp
//
//  Created by Mac-HOME on 14.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    var sentence: Sentence! {
        didSet {
            sentenceLabel.text = sentence.text
            translationLabel.text = sentence.translation
        }
    }
    
    let sentenceLabel: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        sl.numberOfLines = 0
        return sl
    }()
    
    let translationLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tl.numberOfLines = 0
        return tl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .lightBlue
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let overallStackView = UIStackView(arrangedSubviews: [sentenceLabel, translationLabel])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fill
        overallStackView.spacing = 4
        
        overallStackView.backgroundColor = .lightRed
        overallStackView.layer.cornerRadius = 10
        overallStackView.clipsToBounds = true

        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 40, left: 16, bottom: 40, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
