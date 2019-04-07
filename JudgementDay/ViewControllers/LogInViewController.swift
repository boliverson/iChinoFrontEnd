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
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView: UIVisualEffectView!
    var activityIndicator: UIActivityIndicatorView!
    
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
            startActivityIndicator()
            let LU = LoginUser()
            LU.loginDelegate = self
            LU.loginRequest(email: txtEmail.text!, password: (txtPassword.text?.sha256())!)
        } else {
            let alert = UIAlertController(title: "Alomst There...", message: "Please enter your email and password to sign in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showUsedEmailAlert() {} //Implemented in another class
    
    func userAuthenticationResponse(response: Bool) {
        stopActivityIndicator()
        if response{
            let storyboard = UIStoryboard(name: "UserAccount", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "UserAccountViewController") as! UserAccountViewController
            self.present(controller, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Oh No...", message: "Your email or password was not found. Please try again or create a new account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
                self.txtPassword.text = ""
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startActivityIndicator() -> Void {
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = blurEffectView.center
        activityIndicator.alpha = 0.0
        blurEffectView.alpha = 0.0
        view.addSubview(blurEffectView)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1.0
            self.activityIndicator.alpha = 1.0
        }
    }
    
    func stopActivityIndicator() -> Void{
        UIView.animate(withDuration: 0.25, animations: {
            self.blurEffectView.alpha = 0.0
            self.activityIndicator.alpha = 0.0
        }, completion: { finished in
            self.activityIndicator.stopAnimating()
            self.blurEffectView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
        })
    }
    
    
    
}
