//
//  EntityInteractor.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/8/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EntityInteractor: NSObject {
    
    class func getEntityWithId(entityName: String, entityId: Int64, context: NSManagedObjectContext) -> Any {
        let request = NSFetchRequest<NSFetchRequestResult>.init()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        request.entity = entity
        let predicate = NSPredicate.init(format: "serverKey = %d", entityId)
        request.predicate = predicate
        
        var result: Any = ()
        var items: [Any] = []
        
        context.persistentStoreCoordinator?.performAndWait {
            do{
                items = try context.fetch(request)
            }catch{
                print(error)
            }
        }
        
        if items.count > 0 {
            result = items[0]
        }
        return result
    }
}
