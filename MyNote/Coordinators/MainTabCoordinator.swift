//
//  MainTabCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 19/02/2022.
//

import Foundation
import UIKit

class MainTabCoordinator: BaseCoordinator {
    var tabBarController: BottomTabViewController?
    override func start() {
        showTabBarController()
    }
    
    private func showTabBarController() {
        tabBarController = BottomTabViewController.instantiate(fromAppStoryboard: .MainTabBar)
        tabBarController?.tabBardelegate = self
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([tabBarController!], animated: false)
    }
    
    private func runNoteTabFlow(with navigationController: UINavigationController) {
        if navigationController.viewControllers.isEmpty {
            let coordinator = NoteCoordinator(with: navigationController)
            coordinator.start()
            self.addDependency(coordinator)
        }
    }
    
    private func runTodoTabFlow(with navigationController: UINavigationController) {
        if navigationController.viewControllers.isEmpty {
            let coordinator = TodoCoordinator(with: navigationController)
            coordinator.start()
            self.addDependency(coordinator)
        }
    }
}

extension MainTabCoordinator: BottomTabViewControllerDelegate {
    func onNoteTabFlowSelect(with navigationController: UINavigationController) {
        runNoteTabFlow(with: navigationController)
    }
    
    func onTodoTabFlowSelect(with navigationController: UINavigationController) {
        runTodoTabFlow(with: navigationController)
    }
}
