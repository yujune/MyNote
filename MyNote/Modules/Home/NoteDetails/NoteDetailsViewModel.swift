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
    var reloadBottomCollectionTableViewClosure: (()->())?
    var bottomButtonArray: [ButtonDisplayModel] = [ButtonDisplayModel]() {
        didSet {
            reloadBottomCollectionTableViewClosure?()
        }
    }
    var deleteNoteClosure: (()->())?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func setupBottomCollectionViewData() {
        let shareButton = ButtonDisplayModel(title: "Share".localized(), image: UIImage(systemName: "paperplane"), buttonType: .share)
        let starImage = note?.isFavourite ?? false ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let starButton = ButtonDisplayModel(title: "Favourite".localized(), image: starImage, buttonType: .favourite)
        let deleteButton = ButtonDisplayModel(title: "Delete".localized(), image: UIImage(systemName: "trash"), buttonType: .delete)
        let moreButton = ButtonDisplayModel(title: "More".localized(), image: UIImage(named: "more"), buttonType: .more)
        bottomButtonArray = [shareButton, starButton, deleteButton, moreButton]
    }
    
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
    
    func favouriteNote() {
        guard let note = self.note else {
            return
        }
        note.isFavourite = !note.isFavourite
        
        do {
            try context.save()
            setupBottomCollectionViewData()
            reloadBottomCollectionTableViewClosure?()
            NotificationCenter.default.post(name: .refreshNotes, object: nil)
        }catch {
            print("Error saving context\(error)")
        }
    }
    
    func editNote(with noteModel: NoteModel) {
        guard let note = self.note else {
            return
        }
        
        guard let selectedCategory = getSelectedCategory(name: noteModel.category?.name ?? "") else {
            return
        }
        
        note.title = noteModel.title
        note.detailsText = noteModel.detailsText
        note.isFavourite = noteModel.isFavourite ?? false
        note.createdDate = noteModel.createdDate
        note.parentCategory = selectedCategory
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .refreshNotes, object: nil)
        }catch {
            print("Error saving context\(error)")
        }
    }
    
    func deleteNote() {
        guard let note = note else {
            return
        }
        NoteModel.delete(with: note)
        NotificationCenter.default.post(name: .refreshNotes, object: nil)
        deleteNoteClosure?()
    }
}
