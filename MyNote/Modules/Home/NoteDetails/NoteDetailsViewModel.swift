//
//  NoteDetailsViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import Foundation
import UIKit

class NoteDetailsViewModel: NoteDetailsViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
    
    func saveData(newNote note: NoteModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newNote = Note(context: context)
        newNote.title = note.title
        newNote.category = note.category
        newNote.isFavourite = note.isFavourite ?? false
        newNote.createdDate = note.createdDate
        
        do {
            try context.save()
        }catch {
            print("Error saving context\(error)")
        }
    }
}
