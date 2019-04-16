//
//  CreateCompetitionViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/10/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class CreateCompetitionViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var creatEventView: UIView!
    @IBOutlet weak var whenHeight2: NSLayoutConstraint!
    @IBOutlet weak var whereHeight: NSLayoutConstraint!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.txtLastName.delegate = self
        self.txtStartDate.delegate = self
        
    }
    @IBAction func didSelectCreate(_ sender: Any) {
        
    }
    @IBAction func didSelectCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.whereHeight.constant = 64.0
        self.creatEventView.isHidden = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.whereHeight.constant = 64.0
        self.creatEventView.isHidden = false
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(self.txtStartDate == textField) {
            //  self.whenHeight2.constant = -200.0
            self.whereHeight.constant = -50
            self.creatEventView.isHidden = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if(self.txtStartDate == textField) {
            //self.whenHeight2.constant = 64.0
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
}
