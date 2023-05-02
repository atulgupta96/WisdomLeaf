//
//  Extensions.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    func alert(_ title: String, _ message: String? = nil, _ action: String = "Okay", _ onClick: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: action, style: .default, handler: onClick)
            controller.addAction(defaultAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showLoader(activityColor: UIColor = .lightGray, backgroundColor: UIColor = .black.withAlphaComponent(0.4)) {
        
        DispatchQueue.main.async {
            let backgroundView = UIView()
            backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            backgroundView.backgroundColor = backgroundColor
            backgroundView.tag = 9999
            
            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            
            if #available(iOS 13.0, *) {
                activityIndicator.style = .medium
            }
            activityIndicator.color = activityColor
            activityIndicator.startAnimating()
            
            backgroundView.addSubview(activityIndicator)

            self.view.addSubview(backgroundView)
        }
    }

    func removeLoader() {
        DispatchQueue.main.async {
            if let background = self.view.viewWithTag(9999) {
                background.removeFromSuperview()
            }
        }
    }
}

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
}
