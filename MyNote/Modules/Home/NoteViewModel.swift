//
//  NoteViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit
import CoreData

class NoteViewModel: NoteViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
    var reloadNoteTableView: (() -> Void)?
    var noteArray: [Note]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadData(){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            noteArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        reloadNoteTableView?()
    }
    
    func searchNote(for title: String){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            noteArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        reloadNoteTableView?()
    }
}
