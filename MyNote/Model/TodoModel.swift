//
//  TodoModel.swift
//  MyNote
//
//  Created by Tee Yu June on 27/02/2022.
//

import UIKit
import CoreData

struct TodoModel {
    var isCompleted: Bool?
    var title: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save() {
        let todo = Todo(context: context)
        todo.isCompleted = self.isCompleted ?? false
        todo.name = self.title
        do {
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func loadTodo() -> [Todo] {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        do {
            var todoList: [Todo]
            try todoList = context.fetch(request)
            return todoList
        }catch {
            print("Error fetching data from context \(error)")
        }
        return []
    }
}
