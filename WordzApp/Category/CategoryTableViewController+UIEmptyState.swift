//
//  CategoryTableViewController+UIEmptyState.swift
//  WordzApp
//
//  Created by Mac-HOME on 23.07.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIEmptyState

// It can be reaplaced by footer implementation
extension CategoryTableViewController: UIEmptyStateDelegate, UIEmptyStateDataSource {

    var emptyStateImage: UIImage? {
        return #imageLiteral(resourceName: "empty_state")
    }

    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.882, green: 0.890, blue: 0.859, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: "Здесь пока пусто", attributes: attrs)
    }
    
    func setupEmptyState() {
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        self.reloadEmptyState()
    }
}
