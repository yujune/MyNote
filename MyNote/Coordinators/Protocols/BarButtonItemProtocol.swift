//
//  BarButtonItemProtocol.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

@objc protocol BarButtonItemProtocol {
    @objc func addBarButtonPressed()
}

extension BarButtonItemProtocol {
    func addIconBarButton() -> UIBarButtonItem {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addBarButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        return UIBarButtonItem(customView: button)
    }
}
