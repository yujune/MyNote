//
//  TodoViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 26/02/2022.
//


import Foundation
import UIKit

class TodoViewModel: TodoViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
    var reloadTableViewClosure: (() -> Void)?
    var roloadTableViewHeaderClosure: (() -> Void)?
    var todoArray: [[Todo]] {
        let todoModel = TodoModel()
        let list = todoModel.loadTodo()
        let todoList = list.filter { todo in
            return todo.isCompleted == false
        }
        let completedList = list.filter { todo in
            return todo.isCompleted == true
        }
        return [todoList, completedList]
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var todoList: [[String]] = [["Exercise", "Reading"], ["Swimming"]]

    func saveData(with model: TodoModel) {
        model.save()
    }
    
    func toggleTodo(with todo: Todo) {
        todo.isCompleted = !todo.isCompleted
        do {
            try context.save()
            reloadTableViewClosure?()
            roloadTableViewHeaderClosure?()
        }catch {
            print(error)
        }
    }
}
