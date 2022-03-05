//
//  NodataTableViewCell.swift
//  MyNote
//
//  Created by Tee Yu June on 28/02/2022.
//

import UIKit

class NodataTableViewCell: UITableViewCell {
    @IBOutlet var nodataLabel: UILabel! {
        didSet {
            nodataLabel.text = "No Data".localized()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDisplay(with label: String) {
        nodataLabel.text = label
    }
    
}
