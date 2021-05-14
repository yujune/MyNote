//
//  NoteDetailsViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 14/05/2021.
//


import Foundation
import UIKit

class NoteDetailsViewModel: NoteDetailsViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
}
