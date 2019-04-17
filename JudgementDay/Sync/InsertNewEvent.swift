//
//  InsertNewEvent.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

class InsertNewEvent: LambdaBase {
    func createEventDictionary(event: Event){
        let eventDictionary : [String:String] = ["name" : event.name ?? "iChino",
                                                "location" : event.location ?? "3750Class",
                                                "startTime" : String(describing: event.startDate!).dbFormatDateString(),
                                                "endTime" : String(describing: event.endDate!).dbFormatDateString()]
        
        self.upload(functionName: "createEvent", jsonRequest: eventDictionary, objectId: event.objectID)
    }
}
