//
//  NoteDetailsView.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit

class NoteDetailsView: UIView {
    
    @IBOutlet weak var title: UITextField! {
        didSet {
            title.placeholder = "Title".localized()
        }
    }
    @IBOutlet weak var createdDate: UILabel! {
        didSet {
            createdDate.text = Date.getCurrentDateInString(dateStyle: .medium)
        }
    }
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteDetailsTextView: UITextView! {
        didSet {
            noteDetailsTextView.text = "Write something...".localized()
        }
    }
    @IBOutlet var bottomCollectionView: UICollectionView! {
        didSet {
            bottomCollectionView.registerCell(with: ButtonCollectionViewCell.self)
            if let layout = bottomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            }
            bottomCollectionView.isScrollEnabled = false
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
