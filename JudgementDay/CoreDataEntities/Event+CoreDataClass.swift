//
//  Event+CoreDataClass.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    
    func syncWithServer() -> Void /*Maybe change this to bool later*/ {
        if self.serverKey == 0 {
            let INE = InsertNewEvent()
            INE.createEventDictionary(event: self)
        }
    }
    
    class func getUserWithId(eventId: Int64) -> Event? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let event:Event? = EntityInteractor.getEntityWithId(entityName: "Event", entityId: eventId, context: context) as? Event
        if event != nil{
            return event
        } else{
            return nil
        }
    }

}
