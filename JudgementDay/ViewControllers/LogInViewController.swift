//
//  LogInViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate, LambdaBoolResponse{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var currentUserId: Int64 = 0

    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView: UIVisualEffectView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(userDownloaded), name: .userDownloadedNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateAccount" {
            let newAccountVC = segue.destination as! NewUserViewController
            newAccountVC.userEmail = txtEmail.text ?? ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didSelectSignIn(_ sender: Any) {
        if (txtEmail.text != nil && txtEmail.text != "" && txtPassword.text != nil && txtPassword.text != "") {
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            startActivityIndicator(blur: blurEffectView, ai: activityIndicator)
            let email = txtEmail.text!
            guard let password = txtPassword.text?.sha256() else { return }
            DispatchQueue.global(qos: .background).async {
                let LU = LoginUser()
                LU.loginDelegate = self
                LU.loginRequest(email: email, password: password)
            }
        } else {
            let alert = UIAlertController(title: "Alomst There...", message: "Please enter your email and password to sign in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showUsedEmailAlert() {} //Implemented in another class
    
    func userAuthenticationResponse(response: Bool, userId: Int64) {
        
        currentUserId = userId
        let user = User.getUserWithId(userId: userId)
        if user == nil{
            let DU = DownloadUser()
            DU.downloadUser(userId: userId)
        } else {
            DispatchQueue.main.async {
                self.stopActivityIndicator(blur: self.blurEffectView, ai: self.activityIndicator)
                if response{
                    let storyboard = UIStoryboard(name: "UserAccount", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "UserAccountViewController") as! UserAccountViewController
                    controller.currentUser = User.getUserWithId(userId: userId)
                    self.present(controller, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Oh No...", message: "Your email or password was not found. Please try again or create a new account.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
                        self.txtPassword.text = ""
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func userDownloaded() -> Void {
        DispatchQueue.main.async {
            self.stopActivityIndicator(blur: self.blurEffectView, ai: self.activityIndicator)
            let storyboard = UIStoryboard(name: "UserAccount", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "UserAccountViewController") as! UserAccountViewController
            controller.currentUser = User.getUserWithId(userId: self.currentUserId)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    //*here delete later when you hook up with rachels view: only for testing
    @IBAction func goToCreateEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Event", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
}
