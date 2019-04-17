//
//  DownloadCompetition.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/16/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import CoreData

class DownloadCompetition: LambdaBase {
    
    func downloadCompetitionsForEvent(eventId: Int64) -> Void {
        let compRequest: [String: String] = ["ID" : String(describing: eventId)]
        self.downloadEntity(functionName: "getAllCompsForEvent", jsonRequest: compRequest)
    }
    
    /*
     Expected Input:
     - Type: JSON
     - Format:
     {
     "eventID": "3" (Type: String)
     }
     
     Normal Output:
     - Type: JSON
     - Format:
     {
     Competitions: [
     {
     "ID":           "12"                        (Type: String)
     "eventID":      "12"                        (Type: String)
     "name":         "100m Dash",                (Type: String)
     "location":     "4189 S 600 W Roy, Utah",   (Type: String)
     "startTime":    "1994-10-28T09:23:00Z",     (Type: String*)
     "endTime":      "1994-10-28T08:55:00Z",     (Type: String*)
     "isActive":     "true",                     (Type: Boolean)
     },
     {
     "ID":           "12"                        (Type: String)
     "eventID":      "12"                        (Type: String)
     "name":         "100m Dash",                (Type: String)
     "location":     "4189 S 600 W Roy, Utah",   (Type: String)
     "startTime":    "1994-10-28T09:23:00Z",     (Type: String*)
     "endTime":      "1994-10-28T08:55:00Z",     (Type: String*)
     "isActive":     "true",                     (Type: Boolean)
     },
     ]
     }

    */
    
    override func persistData(item: [String : Any]) {
        
        if (item["Competitions"] == nil){
            saveDownloadedData(item: item)
        } else {
            let allComps = item["Competitions"] as! [[String:Any]]
            for comp in allComps{
                saveDownloadedData(item: comp)
            }
            NotificationCenter.default.post(name: .competitionsForEventDownloadedNotification, object: nil)
        }
        
    }
    
    func saveDownloadedData(item: [String:Any]) -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let serverKey = Int64(item["ID"] as? String ?? "0") else { return }
        
        var comp = EntityInteractor.getEntityWithId(entityName: "Competition", entityId: serverKey, context: context) as? Competition
        let event = EntityInteractor.getEntityWithId(entityName: "Event", entityId: Int64(item["eventID"] as? String ?? "0")!, context: context) as? Event
        
        if comp == nil {
            comp = Competition.init(entity: NSEntityDescription.entity(forEntityName: "Competition", in: context)!, insertInto: context)
        }
        
        if event != nil{
            comp?.event = event
            event?.serverKey = Int64(item["eventID"] as? String ?? "0")!
        }
        
        comp?.serverKey = serverKey
        comp?.name = item["name"] as? String
        comp?.location = item["location"] as? String
        comp?.startDate = (item["startTime"] as? String)?.toDate() as NSDate?
        comp?.endDate = (item["endTime"] as? String)?.toDate() as NSDate?
        comp?.isActive = item["isActive"] as? Bool ?? true
        
        do {
            try context.save()
        } catch{
            print("Unexpected error: \(error).")
        }
        
    }
}
