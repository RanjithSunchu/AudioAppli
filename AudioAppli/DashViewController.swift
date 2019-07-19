//
//  DashViewController.swift
//  AudioAppli
//
//  Created by Ranjith Kumar Sunchu on 19/07/19.
//  Copyright © 2019 HungDo. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        
        guard let sideMenu = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? HomeViewController else { return }
        //        menuViewController.didTapMenuType = { menuType in
        //            self.transitionToNew(menuType)
        
        
        sideMenu.modalPresentationStyle = .overCurrentContext
        sideMenu.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        present(sideMenu, animated: true)
        
    }
    

}

extension DashViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
}
