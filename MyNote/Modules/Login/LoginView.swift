//
//  LoginView.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import UIKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit() {
        self.fromNib()
    }
}
