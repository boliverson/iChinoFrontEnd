//
//  LambdaBase.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/2/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import AWSLambda

class LambdaBase: NSObject {
    
    let objectId: NSManagedObjectID! = nil
    var object: NSManagedObject! = nil
    
    func upload(functionName: String, jsonRequest: [String:String]) -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let lambda = AWSLambdaInvoker.default()
            
            lambda.invokeFunction(functionName, jsonObject: jsonRequest).continueWith(block: { (task) in
                
                if (task.result != nil){
                    print("\(task.result ?? "Received a null response" as AnyObject)")
                }else{
                    self.object = context.object(with: self.objectId)
                    
                }
                return nil
            })
            try object.managedObjectContext?.save()
            
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
