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
    
    @IBOutlet var userInput: UITextField?
    @IBOutlet var score: UITextField?
    @IBOutlet var outOf: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
