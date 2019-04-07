//
//  ViewController.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 2/20/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var profileImg: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Testing")
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
    }


}

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
        
        
    }
    
    
    
    
}
