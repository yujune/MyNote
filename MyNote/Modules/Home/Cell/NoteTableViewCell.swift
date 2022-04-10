//
//  NoteTableViewCell.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit
import TagListView

protocol NoteTableViewCellDelegate {
    func favouriteButtonOnPress(with note: Note);
}

class NoteTableViewCell: UITableViewCell {

    var delegate: NoteTableViewCellDelegate?
    var note: Note?
    @IBOutlet weak var noteTagListView: TagListView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteCreatedDate: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDisplay(note: Note){
        self.note = note
        setUpNoteTagListView(note)
        noteTitle.text = note.title
        noteCreatedDate.text = note.createdDate
        favoriteButton.setTitle("", for: .normal)
        if (note.isFavourite) {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    private func setUpNoteTagListView(_ note: Note) {
        var tagIndex = 0
        noteTagListView.removeAllTags()
        guard note.parentCategory?.name != CategoryName.all.rawValue else {
            return
        }
        noteTagListView.addTag(note.parentCategory?.name ?? "")
        noteTagListView.tagViews[tagIndex].tagBackgroundColor = getCategoryUIColor(from: note.parentCategory?.color ?? "")
        noteTagListView.textColor = UIColor.white
        
        if note.isFavourite {
            noteTagListView.addTag("Favourite")
            tagIndex += 1
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.yellow
            noteTagListView.tagViews[tagIndex].textColor = UIColor.gray
        }
    }
    
    private func getCategoryUIColor(from color: String) -> UIColor {
        switch color {
        case CategoryColor.red.rawValue:
            return UIColor.red
        case CategoryColor.blue.rawValue:
            return UIColor.blue
        case CategoryColor.gray.rawValue:
            return UIColor.gray
        default:
            return UIColor.gray
        }
    }
    
    @IBAction func favoriteButtonOnPress(_ sender: UIButton) {
        guard let note = note else {
            return
        }
        delegate?.favouriteButtonOnPress(with: note);
    }
}
