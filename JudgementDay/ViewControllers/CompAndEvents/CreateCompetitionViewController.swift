//
//  CreateCompetitionViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/10/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class CreateCompetitionViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didSelectCreate(_ sender: Any) {
        
    }
    @IBAction func didSelectCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
