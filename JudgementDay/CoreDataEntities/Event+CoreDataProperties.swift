//
//  Event+CoreDataProperties.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/15/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var isActive: Bool
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var serverKey: Int64
    @NSManaged public var startDate: NSDate?
    @NSManaged public var competitions: NSSet?

}

// MARK: Generated accessors for competitions
extension Event {

    @objc(addCompetitionsObject:)
    @NSManaged public func addToCompetitions(_ value: Competition)

    @objc(removeCompetitionsObject:)
    @NSManaged public func removeFromCompetitions(_ value: Competition)

    @objc(addCompetitions:)
    @NSManaged public func addToCompetitions(_ values: NSSet)

    @objc(removeCompetitions:)
    @NSManaged public func removeFromCompetitions(_ values: NSSet)

}
