//
//  TodoViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 26/02/2022.
//


import UIKit

enum TodoSection: Int {
    case Todo
    case Completed
    
    func getTodoSectionTitle() -> String {
        switch self {
        case .Todo:
            return "Todo".localized()
        case .Completed:
            return "Completed".localized()
        default:
            return ""
        }
    }
}

class TodoViewController: UIViewController {
    
    var viewModel: TodoViewModel!
    private var vcView : TodoView { return view as! TodoView }
    
    override func loadView() {
        view = TodoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TODO".localized()
        setupTableView()
        setupBindings()
    }
    
    func setupTableView() {
        vcView.tableView.estimatedRowHeight = 50
        vcView.tableView.rowHeight = UITableView.automaticDimension
        vcView.tableView.delegate = self
        vcView.tableView.dataSource = self
        vcView.tableView.estimatedRowHeight = 100
        vcView.tableView.rowHeight = UITableView.automaticDimension
        updateHeader()
    }
    
    func setupBindings() {
        viewModel.reloadTableViewClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.vcView.tableView.reloadData()
        }
        viewModel.roloadTableViewHeaderClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.updateHeader()
        }
    }
    
    func updateHeader() {
        guard let headerView = vcView.tableView.dequeueReusableHeaderFooterView(withIdentifier: TodoHeader.identifier) as? TodoHeader else {
            print("fail to dequeue")
            return
        }
        headerView.updateDisplay(with: "\(viewModel.todoArray[TodoSection.Todo.rawValue].count) todos, \(viewModel.todoArray[TodoSection.Completed.rawValue].count) completed")
        vcView.tableView.tableHeaderView = headerView
    }
}

//MARK: - UITableViewDataSource
extension TodoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.todoArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == TodoSection.Todo.rawValue && viewModel.todoArray[section].isEmpty) {
            return 1
        }
        return section == TodoSection.Todo.rawValue ? viewModel.todoArray[section].count : viewModel.todoArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == TodoSection.Todo.rawValue && viewModel.todoArray[TodoSection.Todo.rawValue].isEmpty) {
            return dequeueNoDataTableViewCell(indexPath: indexPath)
        }
        return dequeueTodoTableViewCell(indexPath: indexPath)
    }
    
    func dequeueNoDataTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vcView.tableView.dequeueReusableCell(withIdentifier: NodataTableViewCell.identifier, for: indexPath) as? NodataTableViewCell  else {
            fatalError()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func dequeueTodoTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vcView.tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else {
            fatalError()
        }
        let todo = viewModel.todoArray[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        cell.updateDisplay(with: todo)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == TodoSection.Todo.rawValue) {
            return TodoSection.Todo.getTodoSectionTitle()
        }
        
        if (viewModel.todoArray[TodoSection.Completed.rawValue].isEmpty) {
            return ""
        }
        
        return TodoSection.Completed.getTodoSectionTitle()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Delete".localized()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteTodo(with: viewModel.todoArray[indexPath.section][indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

//MARK: - Private
extension TodoViewController {
    
}

extension TodoViewController: BarButtonItemProtocol {
    func addBarButtonPressed() {
        let alert = UIAlertController(title: "Todo".localized(), message: "Add you todo here".localized(), preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save".localized(), style: .default) {action in
            guard let todo = alert.textFields?[0] else {
                return
            }
            var todoModel = TodoModel()
            todoModel.title = todo.text
            todoModel.isCompleted = false
            self.viewModel.saveData(with: todoModel)
            self.updateHeader()
            self.vcView.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Write something...".localized()
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TodoViewController: TodoTableViewCellDelegate {
    func checkButtonPress(with todo: Todo) {
        viewModel.toggleTodo(with: todo)
    }
}
