//
//  CreateUserCell.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/7/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class CreateUserCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var txtField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        txtField.text = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
