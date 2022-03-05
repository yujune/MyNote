//
//  BottomTabViewController.swift
//  MyNote
//
//  Created by Tee Yu June on 18/02/2022.
//


import UIKit

protocol BottomTabViewControllerDelegate : AnyObject {
    func onNoteTabFlowSelect(with navigationController: UINavigationController)
    func onTodoTabFlowSelect(with navigationController: UINavigationController)
}

class BottomTabViewController: UITabBarController {
    
    var viewModel: BottomTabViewModel!
    
    var tabBardelegate: BottomTabViewControllerDelegate?
    
    enum Flows: Int {
        case note = 0,
        todo
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.backgroundColor = UIColor.systemGray6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarItems()
        if let controller = customizableViewControllers?[Flows.note.rawValue] as? UINavigationController {
            tabBardelegate?.onNoteTabFlowSelect(with: controller)

        }
        self.selectedIndex = Flows.note.rawValue
        self.tabBar.clipsToBounds = true
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .blackOpaque
        self.tabBar.layer.cornerRadius = 0
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupTabBarItems() {
        setupTabBarItemIndex(Flows.note.rawValue, unselected: "note", selected: "note", title: "Note".localized())
         setupTabBarItemIndex(Flows.todo.rawValue, unselected: "checkmark.circle.fill", selected: "checkmark.circle.fill", title: "Todo".localized())
    }
    
    func setupTabBarItemIndex(_ index: Int, unselected: String, selected: String, title: String) {
        guard let tabBarItems = self.tabBar.items else { return }
        let tabBarItem = tabBarItems[index]
        tabBarItem.title = title
        //TODO: use custom image with different color.
        tabBarItem.selectedImage = UIImage(systemName: selected)
        tabBarItem.image = UIImage(systemName: unselected)
        //TODO: unselected text color is not working.
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .selected)
    
    }
}

extension BottomTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        switch selectedIndex {
        case Flows.note.rawValue :
            tabBardelegate?.onNoteTabFlowSelect(with: controller)
            
        case Flows.todo.rawValue :
            tabBardelegate?.onTodoTabFlowSelect(with: controller)
            
        default:
            fatalError()
        }
    }
}
