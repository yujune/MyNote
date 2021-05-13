//
//  LoginViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    private var vcView : LoginView { return view as! LoginView }
    
    override func loadView() {
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        
    }
}

//MARK: - UITableViewDataSource
extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
        
    }
}

//MARK: - UITableViewDelegate
extension LoginViewController: UITableViewDelegate {
}

//MARK: - Private
extension LoginViewController {
    
}
