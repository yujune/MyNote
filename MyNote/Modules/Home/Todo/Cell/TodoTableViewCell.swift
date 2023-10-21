//
//  TodoTableViewCell.swift
//  MyNote
//
//  Created by Tee Yu June on 26/02/2022.
//

import UIKit

protocol TodoTableViewCellDelegate {
    func checkButtonPress(with todo: Todo)
}

class TodoTableViewCell: UITableViewCell {
    
    var delegate: TodoTableViewCellDelegate?
    var todoModel: Todo?

    @IBOutlet var checkButton: UIButton! {
        didSet {
            checkButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet var todoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDisplay(with todo: Todo) {
        resetTodoLabel()
        todoModel = todo
        if let isCompleted = todoModel?.isCompleted, isCompleted {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            todoLabel.textColor = .gray
            todoLabel.attributedText = todo.name?.strikeThrough()
        }else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            todoLabel.text = todo.name
        }
        
    }
    
    private func resetTodoLabel() {
        todoLabel.textColor = .black
        todoLabel.attributedText = nil;
    }
    
    @IBAction func checkButtonPress(_ sender: UIButton) {
        guard let todo = todoModel else {
            return
        }
        if let isCompleted = todoModel?.isCompleted, isCompleted {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        delegate?.checkButtonPress(with: todo)
    }
}
