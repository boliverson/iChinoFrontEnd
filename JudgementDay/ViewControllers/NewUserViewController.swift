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

    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        txtEmail.text = userEmail

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
        notValid.validateEmailDelegate = self
        notValid.validateEmail(email: userEmail)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showUsedEmailAlert() {
        let alert = UIAlertController(title: "Oh No...", message: "Looks like that email is already in use. Please enter a new email.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
            self.txtEmail.text = ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func userAuthenticationResponse(response: Bool) {} //Handled in another class
    
}
