//
//  InsertNewUser.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/2/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

class InsertNewUser: LambdaBase {
    
    func createUserDictionary(user: User){
        let userDictionary : [String:String] = ["firstName" : user.firstName ?? "iChino",
                                                "lastName" : user.lastName ?? "3750Class",
                                                "preferredName" : "Ben",
                                                "phone" : user.phone ?? "No Phone",
                                                "email" : user.email ?? "No Email",
                                                "pass" : user.password ?? "No Password"]
        
        self.upload(functionName: "createUser", jsonRequest: userDictionary, objectId: user.objectID)
    }
}
