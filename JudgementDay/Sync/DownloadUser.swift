//
//  DownloadUser.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/10/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import CoreData

class DownloadUser: LambdaBase {
    
    func downloadUser(userId: Int64) -> Void {
        let userId: [String: String] = ["ID" : String(describing: userId)]
        self.downloadEntity(functionName: "getUser", jsonRequest: userId)
    }
    
/*
     {
     "firstName": "Bill",        (Type: String)
     "lastName": "Bob",          (Type: String)
     "preferredName": "Billy",   (Type: String)
     "phone": "385-375-9774",    (Type: String)
     "email": "bill@gmail.com",  (Type: String)
     }
*/
    override func persistData(item: [String : Any]) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let serverKey = Int64(item["ID"] as? String ?? "0") else { return }
        
        var user = EntityInteractor.getEntityWithId(entityName: "User", entityId: serverKey, context: context) as? User
        
        if user == nil {
            user = User.init(entity: NSEntityDescription.entity(forEntityName: "User", in: context)!, insertInto: context)
        }
        user?.serverKey = serverKey
        user?.firstName = item["firstName"] as? String
        user?.lastName = item["lastName"] as? String
        user?.phone = item["phone"] as? String
        user?.email = item["email"] as? String
        
        do {
            try context.save()
        } catch{
            print("Unexpected error: \(error).")
        }
    }
}
