//
//  BottomTabViewModel.swift
//  MyNote
//
//  Created by Tee Yu June on 18/02/2022.
//


import Foundation
import UIKit

class BottomTabViewModel: BottomTabViewModelProtocol {
    var showErrorMessage: ((String) -> Void)?
    var showInfoMessage: ((String) -> Void)?
}
