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
        viewModel.loadData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func setupBindings() {
        vcView.noteTableView.delegate = self
        vcView.noteTableView.dataSource = self
        vcView.searchBar.delegate = self
        vcView.noteTableView.tableFooterView = UIView()
        viewModel.reloadNoteTableView = { [weak self] in
            guard let weakSelf = self else{
                return
            }
            weakSelf.vcView.noteTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension NoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noteArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vcView.noteTableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as? NoteTableViewCell else {
            fatalError()
        }
        cell.selectionStyle = .none
        cell.updateDisplay(note: viewModel.noteArray?[indexPath.row] ?? Note())
        return cell
    }
}

//MARK: - UITableViewDelegate
extension NoteViewController: UITableViewDelegate {
}

//MARK: - Search Bar
extension NoteViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true {
            viewModel.loadData()
        }else {
            viewModel.searchNote(for: searchBar.text ?? "")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    //dismiss keyboard and textField cursor when cancel button is clicked.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            viewModel.loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
