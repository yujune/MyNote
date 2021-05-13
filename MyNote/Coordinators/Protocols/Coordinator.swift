//
//  Coordinator.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
