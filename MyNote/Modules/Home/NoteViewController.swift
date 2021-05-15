//
//  NoteViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import UIKit
import RMPickerViewController

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
        viewModel.loadCategoryData()
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
        vcView.categoryButton.addTarget(self, action: #selector(pickerButtonPressed), for: .touchUpInside)
    }
    
    @objc func pickerButtonPressed(){
        pickerView("Choose category".localized())
    }
    
    private func pickerView(_ title: String){
        let selectAction = RMAction<UIPickerView>(title: "Select".localized(), style: .done) { (selectedValue) in
            
            self.vcView.categoryLabel.text = self.viewModel.noteCategoryArray?[selectedValue.contentView.selectedRow(inComponent: 0)].name
            self.viewModel.filterNote(with: self.vcView.categoryLabel.text ?? "")
        }
        
        let cancelAction = RMAction<UIPickerView>(title: "Cancel".localized(), style: .cancel) { (selectedValue) in
        }
        
        let pickerController = RMPickerViewController(style: .default, title: title, message: nil, select: selectAction, andCancel: cancelAction)!
        
        pickerController.picker.dataSource = self
        pickerController.picker.delegate = self
        
        self.present(pickerController, animated: true, completion: nil)
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

//MARK: - Picker View
extension NoteViewController: UIPickerViewDataSource   {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.noteCategoryArray?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel
        
        if let view = view {
            label = view as! UILabel
        }
        else {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 400))
        }
        
        let title = viewModel.noteCategoryArray?[row].name
        label.text = title
        label.textAlignment = .center
        return label
    }
}

extension NoteViewController: UIPickerViewDelegate {
    
}
