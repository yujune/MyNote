//
//  NoteDetailsViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import UIKit
import RMPickerViewController

class NoteDetailsViewController: UIViewController {
    
    var viewModel: NoteDetailsViewModel!
    private var vcView : NoteDetailsView { return view as! NoteDetailsView }
    
    override func loadView() {
        view = NoteDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.loadCategoryData()
    }
    
    func setupBindings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonPressed))
        vcView.categoryButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
    }
    
    @objc func filterButtonPressed(){
        pickerView("Selecte category".localized())
    }
    
    @objc func saveBarButtonPressed(){
        let newNoteCategory = CategoryModel(name: vcView.categoryLabel.text)
        
        let newNote = NoteModel(title: vcView.title.text, createdDate: Date.getCurrentDateInString(dateStyle: .medium), isFavourite: false, detailsText: vcView.noteDetailsTextView.text, category: newNoteCategory)
        
        viewModel.saveData(newNote: newNote)
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    private func pickerView(_ title: String){
        let selectAction = RMAction<UIPickerView>(title: "Select".localized(), style: .done) { (selectedValue) in
            
            guard let selectedCategory = self.viewModel.noteCategoryArray?[selectedValue.contentView.selectedRow(inComponent: 0)].name else {
                return
            }
            self.vcView.categoryLabel.text = selectedCategory
        }
        
        let cancelAction = RMAction<UIPickerView>(title: "Cancel".localized(), style: .cancel) { (selectedValue) in
        }
        
        let pickerViewController = RMPickerViewController(style: .default, title: title, message: "", select: selectAction, andCancel: cancelAction)!
        
        pickerViewController.picker.delegate = self
        pickerViewController.picker.dataSource = self
        
        self.present(pickerViewController, animated: true, completion: nil)
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

//MARK: - Picker View
extension NoteDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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

extension NoteDetailsViewController: UIPickerViewDelegate {
    
}

