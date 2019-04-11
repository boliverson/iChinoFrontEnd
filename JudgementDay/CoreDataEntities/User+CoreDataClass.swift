//
//  User+CoreDataClass.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 3/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import UIKit
import CoreData

struct CurrentUser {
    static var user: User?
}

@objc(User)
public class User: NSManagedObject {
    
    func syncWithServer() -> Void /*Maybe change this to bool later*/ {
        if self.serverKey == 0 {
            let INU = InsertNewUser()
            INU.createUserDictionary(user: self)
        }
    }
    
    class func getUserWithId(userId: Int64) -> User? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user:User? = EntityInteractor.getEntityWithId(entityName: "User", entityId: userId, context: context) as? User
        if user != nil{
            return user
        } else{
            return nil
        }
    }

}
