//
//  SplashVC.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import UIKit

class SplashVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var mainLogo: UIImageView!
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateLogo()
    }
    
    //MARK: Private Methods
    private func animateLogo() {
        mainLogo.transform = CGAffineTransform(translationX: 0, y: bounds.height - mainLogo.frame.minY)
        
        UIView.animate(withDuration: Constants.splashAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5) {
            self.mainLogo.transform = .identity
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.gotoHome()
        }
    }
    
    private func gotoHome() {
        let vc = HomeVC()
        navigationController?.setViewControllers([vc], animated: true)
    }
}
