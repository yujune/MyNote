//
//  NoteModel.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit
import CoreData

struct NoteModel {
    var title: String?
    var createdDate: String?
    var isFavourite: Bool?
    var detailsText: String?
    var category: CategoryModel?
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func delete(with note: Note) {        
        do {
            let result = try context.existingObject(with: note.objectID)
            context.delete(result)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving data from context \(error)")
        }
    }
}

struct CategoryModel {
    var name: String?
    var color: String {
        return getCategoryColor()
    }
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getCategoryColor() -> String {
        var categoryColor: CategoryColor
        
        switch name {
        case CategoryName.personal.rawValue:
            categoryColor = .blue
            break
        case CategoryName.finance.rawValue:
            categoryColor = .red
            break
        default:
            categoryColor = .gray
            break
        }
        return categoryColor.rawValue
    }
    
    static func isCategoryEmpty() -> Bool {
        return self.loadCategoryData().isEmpty
    }
    
    static func loadCategoryData(request: NSFetchRequest<Category> = Category.fetchRequest()) -> [Category] {
        var noteCategoryArray: [Category] = []
        do {
            noteCategoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return noteCategoryArray
    }
    
    static func save(with categories: [CategoryModel]) {
        for category in categories {
            let newCategory = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)
            newCategory.setValue(category.name, forKey: "name")
            newCategory.setValue(category.color, forKey: "color")
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
