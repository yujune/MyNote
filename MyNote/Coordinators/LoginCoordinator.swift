//
//  LoginCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
    override func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController(){
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
}
