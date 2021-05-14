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
        if note.isFavourite ?? false {
            noteTagListView.addTag("Favourite")
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.yellow
            noteTagListView.textColor = UIColor.black
            tagIndex += 1
        }
        
        switch note.category {
        case Category.personal.rawValue:
            noteTagListView.addTag(Category.personal.rawValue)
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.green
            noteTagListView.textColor = UIColor.black
            
            break
        case Category.finance.rawValue:
            noteTagListView.addTag(Category.finance.rawValue)
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.red
            noteTagListView.textColor = UIColor.black
            
            break
        case Category.other.rawValue:
            noteTagListView.addTag(Category.other.rawValue)
            noteTagListView.tagViews[tagIndex].tagBackgroundColor = UIColor.gray
            noteTagListView.textColor = UIColor.black
            
            break
        default:
            break
        }
    }
    
}
