//
//  Competition+CoreDataProperties.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import Foundation
import CoreData


extension Competition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Competition> {
        return NSFetchRequest<Competition>(entityName: "Competition")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var serverKey: Int64
    @NSManaged public var startDate: NSDate?
    @NSManaged public var event: Event?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension Competition {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
