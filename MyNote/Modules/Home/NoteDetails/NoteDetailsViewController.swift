//
//  NoteDetailsViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit

class NoteDetailsViewController: UIViewController {
    
    var viewModel: NoteDetailsViewModel!
    private var vcView : NoteDetailsView { return view as! NoteDetailsView }
    
    override func loadView() {
        view = NoteDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonPressed))
    }
    
    @objc func saveBarButtonPressed(){
        
        let newNote = NoteModel(title: vcView.title.text, createdDate: Date.getCurrentDateInString(dateStyle: .medium), category: vcView.categoryLabel.text, isFavourite: false)
        
        viewModel.saveData(newNote: newNote)
    }
}

//MARK: - UITableViewDataSource
extension NoteDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
        
    }
}

//MARK: - UITableViewDelegate
extension NoteDetailsViewController: UITableViewDelegate {
}

//MARK: - Private
extension NoteDetailsViewController {
    
}
