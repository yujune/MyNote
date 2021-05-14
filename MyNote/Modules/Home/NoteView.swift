//
//  NoteView.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import UIKit

class NoteView: UIView {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var notesCountLabel: UILabel!
    @IBOutlet weak var noteTableView: UITableView! {
        didSet {
            noteTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        }
    }
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
