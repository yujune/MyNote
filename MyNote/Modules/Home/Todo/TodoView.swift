//
//  TodoView.swift
//  MyNote
//
//  Created by Tee Yu June on 26/02/2022.
//


import UIKit

class TodoView: UIView {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.registerCell(with: TodoTableViewCell.self)
            tableView.registerTableHeaderView(with: TodoHeader.self)
            tableView.registerCell(with: NodataTableViewCell.self)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit() {
        self.fromNib()
    }
}
