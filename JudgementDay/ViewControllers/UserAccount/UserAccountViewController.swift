//
//  UserAccountViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/6/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit
class UserAccountViewController: UIViewController {
    @IBOutlet weak var btnCreateComp: UIButton!
    @IBOutlet weak var btnUsersComp: UIButton!
    @IBOutlet weak var btnCreateEvent: UIView!
    
    @IBOutlet weak var UserEmailTxt: UILabel!
    @IBOutlet weak var UserFirstNameTxt: UILabel!
    @IBOutlet weak var UserLastNameTxt: UILabel!
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentUser != nil {
            UserEmailTxt.text = currentUser?.email
            UserFirstNameTxt.text = currentUser?.firstName
            UserLastNameTxt.text = currentUser?.lastName
        }
    }


    
    
}
