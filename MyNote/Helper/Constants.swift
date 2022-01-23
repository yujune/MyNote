//
//  Constants.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

enum CategoryName: String {
    case all = "All"
    case personal = "Personal"
    case finance = "Finance"
}

enum CategoryColor: String {
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
    case green = "green"
    case gray = "gray"
    case orange = "orange"
}
