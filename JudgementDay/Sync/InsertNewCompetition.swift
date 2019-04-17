//
//  InsertNewCompetition.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/17/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

class InsertNewCompetition: LambdaBase {
    func createCompDictionary(comp: Competition){
        let compDictionary : [String:String] = ["name" : comp.name ?? "iChino",
                                                "location" : comp.location ?? "3750Class",
                                                "startTime" : String(describing: comp.startDate!).dbFormatDateString(),
                                                "endTime" : String(describing: comp.endDate!).dbFormatDateString(),
                                                "eventID" : String(describing: comp.event?.serverKey)]
        
        self.upload(functionName: "createCompetition", jsonRequest: compDictionary, objectId: comp.objectID)
    }
}
