//
//  InsertNewEvent.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

class InsertNewEvent: LambdaBase {
    func createEventDictionary(event: JudgingEvent){
        let eventDictionary : [String:String] = ["name" : event.name ?? "iChino",
                                                "location" : event.location ?? "3750Class",
                                                "startTime" : "Ben",
                                                "endTime" : "No Phone"]
        
        self.upload(functionName: "createEvent", jsonRequest: eventDictionary, objectId: event.objectID)
    }
}
