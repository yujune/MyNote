//
//  BaseCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        
        childCoordinators.append(coordinator)
    }
    
    func navigateToNoteDetails(){
        let vc = NoteDetailsViewController()
        vc.viewModel = NoteDetailsViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}

extension BaseCoordinator: BarButtonItemProtocol {
    func addBarButtonPressed() {
        navigateToNoteDetails()
    }
}
