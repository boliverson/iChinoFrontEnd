//
//  Competition+CoreDataClass.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Competition)
public class Competition: NSManagedObject {

    func syncWithServer() -> Void /*Maybe change this to bool later*/ {
        if self.serverKey == 0 {
            let INC = InsertNewCompetition()
            INC.createCompDictionary(comp: self)
        }
    }
}
