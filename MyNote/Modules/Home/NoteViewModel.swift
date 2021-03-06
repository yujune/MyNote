//
//  NoteViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit
import CoreData

class NoteViewModel: NoteViewModelProtocol {
    weak var delegate: NoteViewModelProtocolDelegate?
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
    var reloadNoteTableView: (() -> Void)?
    var noteArray: [Note]?
    var noteCategoryArray: [Category]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadData(with request: NSFetchRequest<Note> = Note.fetchRequest()){
        do {
            noteArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        reloadNoteTableView?()
    }
    
    func loadCategoryData(request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            noteCategoryArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func filterNote(with name: String){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", name)
        request.predicate = categoryPredicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        loadData(with: request)
    }
    
    func searchNote(for title: String, in category: String){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
        var categoryPredicate: NSPredicate?
        if category != CategoryName.all.rawValue {
            categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", category)
        }
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        
        if let categoryPredicatee = categoryPredicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicatee, predicate])
        }else {
            request.predicate = predicate
        }
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        loadData(with: request)
    }
    
    func hasAnyCategory() -> Bool {
        if let categoryArray = noteCategoryArray {
            return !categoryArray.isEmpty
        }else{
            return false
        }
    }
    
    func deleteNote(with note: Note) {
        NoteModel.delete(with: note)
    }
    
    func favoriteNote(with note: Note) {
        note.isFavourite = !note.isFavourite
        do {
            try context.save()
            reloadNoteTableView?()
        }catch {
            print("Error saving context\(error)")
        }
    }
}
