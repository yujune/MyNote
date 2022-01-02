//
//  NoteDetailsViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit
import CoreData

class NoteDetailsViewModel: NoteDetailsViewModelProtocol {
    var note: Note?
    var isCreateNote: Bool?
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
    var noteCategoryArray: [Category]?
    var selectedCategory: Category?
    var hasContentEdited = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadCategoryData(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            try noteCategoryArray = context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func getSelectedCategory(name: String) -> Category? {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        let predicate = NSPredicate(format: "name MATCHES %@", name)
        request.predicate = predicate
        
        do{
            selectedCategory = try context.fetch(request)[0]
        }catch {
            print("Error fetching data from context \(error)")
        }
        
        return selectedCategory
    }
    
    func saveData(newNote note: NoteModel) {
        guard let selectedCategory = getSelectedCategory(name: note.category?.name ?? "") else {
            return
        }
        
        let newNote = Note(context: context)
        newNote.title = note.title ?? "Untitled"
        newNote.isFavourite = note.isFavourite ?? false
        newNote.createdDate = note.createdDate
        newNote.detailsText = note.detailsText
        newNote.parentCategory = selectedCategory
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .refreshNotes, object: nil)
        }catch {
            print("Error saving context\(error)")
        }
    }
}
