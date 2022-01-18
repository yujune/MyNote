//
//  NoteDetailsView.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit

class NoteDetailsView: UIView {
    
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteDetailsTextView: UITextView!
    
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
    
    func updateDisplay(note: Note?){
        guard let validNote = note else {
            //create note will return out from this funtion.
            return
        }
        title.text = validNote.title
        createdDate.text = validNote.createdDate
        categoryLabel.text = validNote.parentCategory?.name ?? "no category"
        noteDetailsTextView.text = validNote.detailsText
    }
}
