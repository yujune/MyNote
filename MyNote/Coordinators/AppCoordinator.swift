//
//  AppCoordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    override func start() {
        //login will be supported in the future.
        let login = false
        
        if login {
            goToLogin()
        }else {
            goToNoteList()
        }
    }
    
    private func goToLogin(){
        let loginCoordinator = LoginCoordinator(with: self.navigationController)
        loginCoordinator.start()
        addDependency(loginCoordinator)
    }
    
    private func goToNoteList(){
        let noteCoordinator = NoteCoordinator(with: self.navigationController)
        noteCoordinator.start()
        addDependency(noteCoordinator)
    }
}
