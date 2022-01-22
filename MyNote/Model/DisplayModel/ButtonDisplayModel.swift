//
//  ButtonDisplayModel.swift
//  MyNote
//
//  Created by Tee Yu June on 22/01/2022.
//

import Foundation
import UIKit

class ButtonDisplayModel: DisplayModel {
    var buttonType: ButtonType
    
    init(title: String, image: UIImage?, buttonType: ButtonType) {
        self.buttonType = buttonType
        super.init(title: title, image: image)
    }
}
