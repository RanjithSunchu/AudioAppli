//
//  LoginViewController.swift
//  MusicApp
//
//  Created by HungDo on 7/24/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet fileprivate weak var loginButton: GhostButton! { didSet { setupGhostButton() } }
    
    @IBOutlet weak var validationTextField: UITextField! {
        didSet {
            validationTextField.alpha = 0.5
            validationTextField.delegate = self
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            let songs = Song.getSamplePlaylist()
            let randomIndex = Int(arc4random_uniform(UInt32(songs.count)))
            backgroundImageView.image = UIImage(named: songs[randomIndex].imageURL ?? "default")
        }
    }
    
    @IBAction func login() {
        authenticate(username: username, password: username)
    }
    
    @IBAction func usernameTextFieldValueChanged(_ textField: UITextField) {
        if let text = textField.text, text.characters.count > 6 {
            loginButton.appearWithAnimated(true)
            username = text
        } else {
            loginButton.disappearWithAnimated(true)
            username = nil
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    fileprivate var loginAuth = Authentication()
    fileprivate var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    fileprivate func setupGhostButton() {
        loginButton
            .ghostButtonWithColor(UIColor.white)
            .ghostButtonWithBorderWidth(1)
            .ghostButtonWithCornerRadius(5)
        
        loginButton.disappearWithAnimated(false)
    }
    
    fileprivate func moveToHomeViewController() {
        if let homeNavController = self.storyboard?.instantiateViewController(withIdentifier: Controllers.HomeNavigationController) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.player = MusicPlayerCenter()
                appDelegate.window?.rootViewController = homeNavController
            }
        }
    }
    
    fileprivate func clearUI() {
        validationTextField.text = ""
        loginButton.disappearWithAnimated(false)
    }
    
    fileprivate func showLoginAlertForm() {
        let alertController = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { usernameTextField in
            usernameTextField.placeholder = "Username"
        }
        
        alertController.addTextField { passwordTextField in
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
        }
        
        let loginAlertAction = UIAlertAction(title: "Login", style: .destructive) { action in
            let userInfo: [String] = alertController.textFields?.map { $0.text ?? "" } ?? ["", ""]
            
            if self.loginAuth.validate(username: userInfo[0], password: userInfo[1]) {
                self.moveToHomeViewController()
            }
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(loginAlertAction)
        alertController.addAction(cancelAlertAction)
        
        clearUI()
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func authenticate(username: String?, password: String?) {
        guard let username = username else { return }
        guard let password = password else { return }
        
        if loginAuth.validate(username: username, password: password) {
            showLoginAlertForm()
        } else {
            clearUI()
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.alpha = 0.5
        UIView.animate(withDuration: 0.2, animations: { 
            textField.alpha = 1
        }) 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.alpha = 1
        UIView.animate(withDuration: 0.2, animations: { 
            textField.alpha = 0.5
        }) 
    }
    
}

extension LoginViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}

private extension GhostButton {
    
    func appearWithAnimated(_ animated: Bool) {
        if !self.isHidden { return }
        
        if !animated {
            self.alpha = 1
            self.isHidden = true
            return
        }
        
        if self.alpha == 1 { return }
        
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        }) 
    }
    
    func disappearWithAnimated(_ animated: Bool) {
        if self.isHidden { return }
        
        if !animated {
            self.alpha = 0
            self.isHidden = true
            return
        }
        
        if self.alpha == 0 { return }
        
        self.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { completed in
            if completed { self.isHidden = true }
        }) 
    }
    
}
