//
//  BottomTabView.swift
//  MyNote
//
//  Created by Tee Yu June on 18/02/2022.
//


import UIKit

class BottomTabView: UIView {
    
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
