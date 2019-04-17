//
//  DownloadEvent.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/15/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import CoreData

class DownloadEvent: LambdaBase {
    
    func downloadEvent(eventId: Int64) -> Void {
        let eventRequest: [String: String] = ["ID" : String(describing: eventId)]
        self.downloadEntity(functionName: "getEvent", jsonRequest: eventRequest)
    }
    
    func downloadActiveEvents() -> Void {
        let eventRequest = [String: String]()
        self.downloadEntity(functionName: "getAllActiveEvents", jsonRequest: eventRequest)
    }
    
    /*
    {
    "ID":           "12"                        (Type: String)
    "name":         "Our Great Event",          (Type: String)
    "location":     "4189 S 600 W Roy, Utah",   (Type: String)
    "startTime":    "1994-10-28T09:23:00Z",     (Type: String*)
    "endTime":      "1994-10-28T08:55:00Z",     (Type: String*)
    "isActive":     "true",                     (Type: Boolean)
    }
    */
    override func persistData(item: [String : Any]) {
        
        if (item["Events"] == nil){
            saveDownloadedData(item: item)
        } else {
            let allEvents = item["Events"] as! [[String:Any]]
            for event in allEvents{
                saveDownloadedData(item: event)
            }
            NotificationCenter.default.post(name: .eventAllActiveDownloadedNotification, object: nil)
        }
        
    }
    
    func saveDownloadedData(item: [String:Any]) -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let serverKey = Int64(item["ID"] as? String ?? "0") else { return }
        
        var event = EntityInteractor.getEntityWithId(entityName: "Event", entityId: serverKey, context: context) as? Event
        
        if event == nil {
            event = Event.init(entity: NSEntityDescription.entity(forEntityName: "Event", in: context)!, insertInto: context)
        }
        event?.serverKey = serverKey
        event?.name = item["name"] as? String
        event?.location = item["location"] as? String
        event?.startDate = (item["startTime"] as? String)?.toDate() as NSDate?
        event?.endDate = (item["endTime"] as? String)?.toDate() as NSDate?
        event?.isActive = item["isActive"] as? Bool ?? true
        
        do {
            try context.save()
        } catch{
            print("Unexpected error: \(error).")
        }
        
    }
}
