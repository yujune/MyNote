//
//  TodoHeader.swift
//  MyNote
//
//  Created by Tee Yu June on 27/02/2022.
//

import UIKit

class TodoHeader: UITableViewHeaderFooterView {
    @IBOutlet var headerTitle: UILabel! {
        didSet {
            headerTitle.text = "Todos".localized()
        }
    }
    @IBOutlet var statusLabel: UILabel!
    
    func updateDisplay(with label: String) {
        statusLabel.text = label
    }
}
