//
//  User+CoreDataProperties.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 3/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var serverKey: Int64
    @NSManaged public var preferredName: String?
    @NSManaged public var phone: String?
    @NSManaged public var password: String?
    @NSManaged public var isAdmin: Bool

}
