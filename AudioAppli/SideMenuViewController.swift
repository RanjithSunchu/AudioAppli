//
//  SideMenuViewController.swift
//  AudioAppli
//
//  Created by Ranjith Kumar Sunchu on 19/07/19.
//  Copyright © 2019 HungDo. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuTableview: UITableView!
    
    var sideMenuArray = ["My Account","Redeem Points","Transaction History","Notification","Rate Us","Help Center","Policis","Terms & Condition"]
    
    //      let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: SideMenuViewController)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        print("LogOut", terminator: "")
        let alertController = UIAlertController.init(title: "test", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "YES", style: .default, handler: { (action) in
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootViewController
        })
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController .addAction(okAction)
        alertController .addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lblTitle : UILabel = cell.contentView.viewWithTag(20) as! UILabel
        //         lblTitle.text = arrayMenuOptions[indexPath.row]["title"]
        lblTitle.text = sideMenuArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

}
