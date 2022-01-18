//
//  DisplayModel.swift
//  MyNote
//
//  Created by Tee Yu June on 18/01/2022.
//

import Foundation
import UIKit

class DisplayModel {
    var title: String?
    var image: UIImage?
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
