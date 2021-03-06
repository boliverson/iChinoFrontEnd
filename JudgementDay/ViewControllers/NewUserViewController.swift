//
//  NewUserViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import AWSLambda

class NewUserViewController: UIViewController, UITextFieldDelegate, LambdaBoolResponse {    

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var clearViewTop: NSLayoutConstraint!
    @IBOutlet weak var newAccountTop: NSLayoutConstraint!
    @IBOutlet weak var newAccountView: UIView!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        txtEmail.text = userEmail
        self.txtLastName.delegate = self
        self.txtPassword.delegate = self
        self.txtEmail.delegate = self
        self.txtFirstName.delegate = self
        self.txtPhone.delegate = self
        
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCreate(_ sender: Any) {
        if txtEmail.text != "" && txtFirstName.text != "" && txtPassword.text != ""{
            DispatchQueue.global(qos: .background).async {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let user = User.init(entity: NSEntityDescription.entity(forEntityName: "User", in: context)!, insertInto: context)
                user.firstName = self.txtFirstName.text
                user.lastName = self.txtLastName.text
                user.phone = self.txtPhone.text
                user.email = self.txtEmail.text
                user.password = self.txtPassword.text != nil ? (self.txtPassword.text?.sha256())! : "No Password"
                
                do {
                    try context.save()
                } catch{
                    print("Unexpected error: \(error).")
                }
                
                user.syncWithServer()
            }
        } else {
            let alert = UIAlertController(title: "Almost There", message: "Please enter an email, first name, and password to create an account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func checkEmailAvailability(_ sender: Any) {
        userEmail = txtEmail.text ?? ""
        let notValid = Authenticate()
        notValid.validateEmailDelegate = self
        notValid.validateEmail(email: userEmail)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == txtPassword || textField == txtPhone){
            self.clearViewTop?.constant = -50.0
            self.newAccountTop?.constant = 0.0
            self.newAccountView.isHidden = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if(textField == txtPassword || textField == txtPhone){
            self.clearViewTop?.constant = 8.0
            self.newAccountView.isHidden = false
            self.newAccountTop?.constant = 30.0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == txtPassword || textField == txtPhone){
            self.clearViewTop?.constant = 8.0
            self.newAccountView.isHidden = false
            self.newAccountTop?.constant = 30.0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        return true
    }
    
    func showUsedEmailAlert() {
        let alert = UIAlertController(title: "Oh No...", message: "Looks like that email is already in use. Please enter a new email.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
            self.txtEmail.text = ""
        }))
        DispatchQueue.main.async {
             self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    func userAuthenticationResponse(response: Bool, userId: Int64) {} //Handled in another class
    
}
