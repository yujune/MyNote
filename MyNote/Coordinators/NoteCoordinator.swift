//
//  NoteCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

class NoteCoordinator: BaseCoordinator {
    override func start() {
        showNoteViewController()
    }
    
    private func showNoteViewController() {
        let vc = NoteViewController()
        vc.viewModel = NoteViewModel()
        vc.viewModel.delegate = self
        vc.navigationItem.rightBarButtonItem = addIconBarButton()
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }
}

//the protocol func is inside the parent class which is BaseCoordinator.
extension NoteCoordinator: NoteViewModelProtocolDelegate {
}

