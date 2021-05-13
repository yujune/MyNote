//
//  NoteViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//


import Foundation
import UIKit

class NoteViewModel: NoteViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
}
