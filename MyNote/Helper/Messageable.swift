//
//  Messageable.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import Foundation

protocol Messageable: AnyObject {
    var showInfoMessage: ((String) -> Void)? { get set }
    var showErrorMessage: ((String) -> Void)? { get set }
}
