//
//  NoteDetailsView.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit

class NoteDetailsView: UIView {
    
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
