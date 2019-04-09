//
//  NewUserViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/24/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import AWSLambda

class NewUserViewController: UIViewController, UITextFieldDelegate, LambdaBoolResponse, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var txtFirstName: UITextField!
//    @IBOutlet weak var txtLastName: UITextField!
//    @IBOutlet weak var txtPhone: UITextField!
//    @IBOutlet weak var txtEmail: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
    var createLabels = ["Email", "First Name", "Last Name", "Phone", "Password"]
    var txtFldResponses = [String]()
    var userEmail: String = ""
    
    override func viewDidLoad() {
       // txtEmail.text = userEmail
//        scrollView.contentSize = CGSize(width: 269.0, height: 100.0)
        
        tableView.register(UINib(nibName: String(describing: CreateUserCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CreateUserCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCreate(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User.init(entity: NSEntityDescription.entity(forEntityName: "User", in: context)!, insertInto: context)
//        user.firstName = txtFirstName.text
//        user.lastName = txtLastName.text
//        user.phone = txtPhone.text
//        user.email = txtEmail.text
//        user.password = txtPassword.text != nil ? (txtPassword.text?.sha256())! : "No Password"
        
        user.syncWithServer()
        
        print("\(user)")
        
    }
    @IBAction func checkEmailAvailability(_ sender: Any) {
//        userEmail = txtEmail.text ?? ""
        let notValid = Authenticate()
        notValid.delegate = self
        notValid.validateEmail(email: userEmail)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
       // self.scrollView.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func showUsedEmailAlert() {
        let alert = UIAlertController(title: "Oh No...", message: "Looks like that email is already in use. Please enter a new email.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
           // self.txtEmail.text = ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreateUserCell.self), for: indexPath) as! CreateUserCell
        
        cell.lbl.text = createLabels[indexPath.row]
        //cell.textLabel?.text = txtFldResponses[indexPath.row] 

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
