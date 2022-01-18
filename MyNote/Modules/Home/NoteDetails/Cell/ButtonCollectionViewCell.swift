//
//  ButtonCollectionViewCell.swift
//  MyNote
//
//  Created by Tee Yu June on 18/01/2022.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateDisplay(model: DisplayModel) {
        image.image = model.image
        image.setImageColor(color: UIColor.gray)
        title.text = model.title
    }

}
