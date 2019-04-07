//
//  ScoreCardCellController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/3/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class ScoreCardCell: UITableViewCell  {
    
    @IBOutlet var userDescription: UITextField?
   
    @IBOutlet var maxValue: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userDescription?.layer.borderWidth = 3.0
        userDescription?.layer.borderColor = UIColor.init(red: (188.0/255.0), green: (203.0/255.0), blue: (222.0/255.0), alpha: 1.0).cgColor
        
        maxValue?.layer.borderWidth = 3.0
        maxValue?.layer.borderColor = UIColor.init(red: (204.0/255.0), green:(212.0/255.0), blue: (34.0/255.0), alpha: 1.0).cgColor
        
    }
    
    
}
