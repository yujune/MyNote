//
//  NoteTableViewCell.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit
import TagListView

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTagListView: TagListView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteCreatedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDisplay(note: Note){
        setUpNoteTagListView(note)
        noteTitle.text = note.title
        noteCreatedDate.text = note.createdDate
    }
    
    private func setUpNoteTagListView(_ note: Note) {
        var tagIndex = 0
        noteTagListView.removeAllTags()
    
        noteTagListView.addTag(note.parentCategory?.name ?? "")
        noteTagListView.tagViews[tagIndex].tagBackgroundColor = getCategoryUIColor(from: note.parentCategory?.color ?? "")
        noteTagListView.textColor = UIColor.black
        
        if note.isFavourite {
            noteTagListView.addTag("Favourite")
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.yellow
            noteTagListView.textColor = UIColor.black
            tagIndex += 1
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
}
