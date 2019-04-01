//
//  NewUserViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import AWSLambda

class NewUserViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        txtEmail.text = userEmail
//        scrollView.contentSize = CGSize(width: 269.0, height: 100.0)
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
        
        let userDictionary : [String:String] = ["firstName" : user.firstName ?? "iChino",
                                                "lastName" : user.lastName ?? "3750Class",
                                                "preferredName" : "Ben",
                                                "phone" : user.phone ?? "No Phone",
                                                "email" : user.email ?? "No Email",
                                                "pass" : user.password ?? "No Password"]
        
        do {
            let lambda = AWSLambdaInvoker.default()
            
            lambda.invokeFunction("createUser", jsonObject: userDictionary).continueWith(block: { (task) in
                
                if (task.result != nil){
                    print("\(task.result ?? "Received a null response" as AnyObject)")
                }
                return nil
            })
            try user.managedObjectContext?.save()
            
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.scrollView.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
