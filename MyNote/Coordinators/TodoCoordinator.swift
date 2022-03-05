//
//  TodoCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 26/02/2022.
//

import Foundation

class TodoCoordinator: BaseCoordinator {
    override func start() {
        showTodoViewController()
    }
    
    func showTodoViewController() {
        let vc = TodoViewController()
        let viewModel = TodoViewModel()
        vc.viewModel = viewModel
        vc.navigationItem.rightBarButtonItem = vc.addIconBarButton()
        navigationController.pushViewController(vc, animated: false)
    }
}
