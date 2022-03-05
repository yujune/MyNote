//
//  Constants.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

enum AppStoryboard : String {
    
    case MainTabBar
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
    
}

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

enum Colors {
    static let appTheme = UIColor.blue
}
