//
//  NoteModel.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

struct NoteModel {
    var title: String?
    var createdDate: String?
    var isFavourite: Bool?
    var detailsText: String?
    var category: CategoryModel?
}

struct CategoryModel {
    var name: String?
    var color: String {
        return getCategoryColor()
    }
    
    func getCategoryColor() -> String{
        var categoryColor: CategoryColor
        
        switch name {
        case CategoryName.personal.rawValue:
            categoryColor = .blue
            break
        case CategoryName.finance.rawValue:
            categoryColor = .red
            break
        case CategoryName.other.rawValue:
            categoryColor = .gray
            break
        default:
            categoryColor = .gray
            break
        }
        return categoryColor.rawValue
    }
}
