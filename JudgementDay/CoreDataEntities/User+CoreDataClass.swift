//
//  User+CoreDataClass.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 3/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    func syncWithServer() -> Void /*Maybe change this to bool later*/ {
        if self.serverKey == 0 {
            let INU = InsertNewUser()
            INU.createUserDictionary(user: self)
        }
    }

}
