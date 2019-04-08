//
//  NewUserViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import AWSLambda

class NewUserViewController: UIViewController, UITextFieldDelegate, LambdaBoolResponse{

    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginContainerHeight: NSLayoutConstraint!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        txtEmail.text = userEmail
//        scrollView.contentSize = CGSize(width: 269.0, height: 100.0)
        self.txtPhone.delegate = self
        self.txtEmail.delegate = self
        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtPassword.delegate = self
        self.accountHeight.constant = 53
        self.loginContainerHeight.constant = 24
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCreate(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User.init(entity: NSEntityDescription.entity(forEntityName: "User", in: context)!, insertInto: context)
        user.firstName = txtFirstName.text
        user.lastName = txtLastName.text
        user.phone = txtPhone.text
        user.email = txtEmail.text
        user.password = txtPassword.text != nil ? (txtPassword.text?.sha256())! : "No Password"
        
        user.syncWithServer()
        
        print("\(user)")
        
    }
    @IBAction func checkEmailAvailability(_ sender: Any) {
        userEmail = txtEmail.text ?? ""
        let notValid = Authenticate()
        notValid.delegate = self
        notValid.validateEmail(email: userEmail)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.accountHeight.constant = 24.0
        self.loginContainerHeight.constant = 53.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        self.view.endEditing(true)
     
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.accountHeight.constant = 10.0
        self.loginContainerHeight.constant = 10.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func showUsedEmailAlert() {
        let alert = UIAlertController(title: "Oh No...", message: "Looks like that email is already in use. Please enter a new email.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
            self.txtEmail.text = ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var accountHeight: NSLayoutConstraint!
    
    
}
