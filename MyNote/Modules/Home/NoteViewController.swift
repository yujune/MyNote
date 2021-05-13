//
//  NoteViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import UIKit

class NoteViewController: UIViewController {
    
    var viewModel: NoteViewModel!
    private var vcView : NoteView { return view as! NoteView }
    
    override func loadView() {
        view = NoteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        vcView.noteTableView.delegate = self
        vcView.noteTableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension NoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vcView.noteTableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as? NoteTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = "Hello from June"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension NoteViewController: UITableViewDelegate {
}

//MARK: - Private
extension NoteViewController {
    
}
