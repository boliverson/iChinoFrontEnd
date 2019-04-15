//
//  EventCell.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
