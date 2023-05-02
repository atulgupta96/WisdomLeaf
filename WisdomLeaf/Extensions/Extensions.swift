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
}
