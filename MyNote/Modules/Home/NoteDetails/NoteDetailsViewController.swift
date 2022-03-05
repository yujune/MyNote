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
        setupCollectionView()
        viewModel.loadCategoryData()
        vcView.updateDisplay(note: viewModel.note ?? nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupBindings() {
        if (viewModel.isCreateNote ?? true) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonPressed))
        }else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateBarButtonPressed))
        }
       
        vcView.title.delegate = self
        vcView.noteDetailsTextView.delegate = self
        vcView.categoryButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        
        viewModel.reloadBottomCollectionTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let weakSelf = self else {
                    return
                }
                weakSelf.vcView.bottomCollectionView.reloadData()
            }
        }
        viewModel.deleteNoteClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupCollectionView() {
        vcView.bottomCollectionView.delegate = self
        vcView.bottomCollectionView.dataSource = self
        viewModel.setupBottomCollectionViewData()
    }
    
    @objc func filterButtonPressed(){
        pickerView("Selecte category".localized())
    }
    
    @objc func saveBarButtonPressed(){
        let newNoteCategory = CategoryModel(name: vcView.categoryLabel.text)
        
        let newNote = NoteModel(title: vcView.title.text, createdDate: Date.getCurrentDateInString(dateStyle: .medium), isFavourite: false, detailsText: vcView.noteDetailsTextView.text, category: newNoteCategory)
        
        viewModel.saveData(newNote: newNote)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func updateBarButtonPressed() {
        let editedNoteCategory = CategoryModel(name: vcView.categoryLabel.text)
        
        let editedNote = NoteModel(title: vcView.title.text, createdDate: Date.getCurrentDateInString(dateStyle: .medium), isFavourite: false, detailsText: vcView.noteDetailsTextView.text, category: editedNoteCategory)
        
        viewModel.editNote(with: editedNote)
        self.navigationController?.popViewController(animated: true)
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
    
    func handleBottomButtonClick(with model: ButtonDisplayModel) {
        switch model.buttonType {
        case .delete:
            deleteNoteButtonPressed()
            break
        case .share:
            shareButtonPressed()
            break
        case .favourite:
            favouriteButtonPressed()
            break
        case .more:
            break
        default:
            break
        }
    }
    
    func deleteNoteButtonPressed() {
        self.showConfirmationMessage("Are you sure to delete?".localized()){ [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.viewModel.deleteNote()
        }
    }
    
    func shareButtonPressed() {
        guard let note = viewModel.note else {
            return
        }
        
        let activityController = UIActivityViewController(activityItems: [(note.title ?? "") + "\n" + (note.detailsText ?? "")], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        activityController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        self.present(activityController, animated: true) {
        }
    }
    
    func favouriteButtonPressed() {
        viewModel.favouriteNote()
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

//MARK: - UICollectionViewDataSource
extension NoteDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bottomButtonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueButtonCollectionViewCell(collectionView, cellForItemAt: indexPath)
    }
    
    func dequeueButtonCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell else {
            fatalError()
        }
        cell.updateDisplay(model: viewModel.bottomButtonArray[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension NoteDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleBottomButtonClick(with: viewModel.bottomButtonArray[indexPath.row])
    }
}

//MARK: - UICollectionViewFlowLayout
extension NoteDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.width) / viewModel.bottomButtonArray.count, height: Int(collectionView.frame.height))
    }
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

//MARK: - UITextViewDelegate
extension NoteDetailsViewController: UITextFieldDelegate {
    
}

//MARK: - UITextViewDelegate
extension NoteDetailsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Write something..." && !viewModel.hasContentEdited) {
            textView.text = ""
            viewModel.hasContentEdited = true
        }
    }
}
