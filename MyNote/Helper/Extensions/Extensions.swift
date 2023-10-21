//
//  Extensions.swift
//  MyNote
//
//  Created by Tee Yu June on 13/05/2021.
//

import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func strikeThrough() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,value: 2, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}

extension Date {
    static func getCurrentDateInString(dateStyle: DateFormatter.Style) -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        let datetime = formatter.string(from: now)
        return datetime
    }
}

extension Notification.Name {
    static let refreshNotes = Notification.Name("refreshNotes")
}

extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
        return contentView
    }
    
    /// attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }
    
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {
        let view: UIView? = to ?? superview
        let isSuperView = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperView ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
}

extension UIViewController {
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: appName.localized(), message: message.localized(), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action) in
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorMessage(_ message: String, completion: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: appName.localized(), message: message.localized(), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK".localized(), style: .cancel) { (action) in
            completion()
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoMessage(_ message: String) {
        let alertController = UIAlertController(title: appName.localized(), message: message.localized(), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK".localized(), style: .cancel) { (action) in
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title.localized(), message: message.localized(), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK".localized(), style: .cancel) { (action) in
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoMessage(_ message: String, completion: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: appName.localized(), message: message.localized(), preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK".localized(), style: .default) { (action) in
            completion()
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmationMessage(_ message: String, cancelCompletion: (() -> Void)? = nil, confirmCompletion: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: appName.localized(), message: message.localized(), preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) in
            cancelCompletion?()
        }
        let okButton = UIAlertAction(title: "Confirm".localized(), style: .default) { (action) in
            confirmCompletion()
        }
        
        alertController.addAction(cancelButton)
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func registerCell(with cell: UITableViewCell.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
    
    func registerTableHeaderView(with headerView: UITableViewHeaderFooterView.Type) {
        self.register(UINib(nibName: String(describing: headerView), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: headerView))
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

//MARK: - UICollectionView
extension UICollectionView {
    func registerCell(with cell: UICollectionViewCell.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil), forCellWithReuseIdentifier: String(describing: cell))
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

//MARK: - Image
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}
