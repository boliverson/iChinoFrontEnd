//
//  LogInViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, LambdaBoolResponse{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateAccount" {
            let newAccountVC = segue.destination as! NewUserViewController
            newAccountVC.userEmail = txtEmail.text ?? ""
        }
    }
    
    @IBAction func didSelectSignIn(_ sender: Any) {
        if (txtEmail.text != nil || txtEmail.text != "") && (txtPassword.text != nil || txtPassword.text != "") {
            let LU = LoginUser()
            LU.loginRequest(email: txtEmail.text!, password: (txtPassword.text?.sha256())!)
        } else {
            let alert = UIAlertController(title: "Alomst There...", message: "Please enter your email and password to sign in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showUsedEmailAlert() {} //Implemented in another class
    
    func userAuthenticationResponse(response: Bool) {
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
    
    
    
    
}
