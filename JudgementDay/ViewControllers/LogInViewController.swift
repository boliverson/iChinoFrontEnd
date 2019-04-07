//
//  LogInViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateAccount" {
            let newAccountVC = segue.destination as! NewUserViewController
            newAccountVC.userEmail = txtEmail.text ?? ""
        }
    }
    
    @IBAction func didSelectSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserAccount", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "UserAccountViewController") as! UserAccountViewController
        self.present(controller, animated: true, completion: nil)
       //UserAccountViewController
    }
    
    
    
    
}
