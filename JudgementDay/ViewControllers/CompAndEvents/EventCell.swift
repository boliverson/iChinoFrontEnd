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
    
    func setUpCell(event: Event) -> Void {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let tempEvent = context.object(with: event.objectID) as! Event
        eventName.text = event.name != nil ? event.name : ""
        location.text = event.location != nil ? event.location : ""
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, yyyy - h:mm a"
        startDateTime.text = event.startDate != nil ? dateFormat.string(from: event.startDate! as Date) : ""
        endDateTime.text = event.endDate != nil ? dateFormat.string(from: event.endDate! as Date) : ""
    }
}
