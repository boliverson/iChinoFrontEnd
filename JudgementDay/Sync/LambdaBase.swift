//
//  LambdaBase.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/2/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import AWSLambda

class LambdaBase: NSObject {
    
    var object: NSManagedObject! = nil
    var delegate: LambdaBoolResponse?
    
    func upload(functionName: String, jsonRequest: [String:String], objectId: NSManagedObjectID) -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let lambda = AWSLambdaInvoker.default()
        
        lambda.invokeFunction(functionName, jsonObject: jsonRequest).continueWith(block: { (task) in
            
            if (task.result != nil){
                let id = Int64(task.result?.value(forKey: "ID") as? String ?? "0")
                
                self.object = context.object(with: objectId) as NSManagedObject
                
                (self.object as! Uploadable).serverKey = id ?? 0
                
                do {
                    try self.object.managedObjectContext?.save()
                } catch{
                    print("Unexpected error: \(error).")
                }
                
            }else{
                print("Error: \(String(describing: task.error))")
            }
            return nil
        })
    }
    
    
    func serverValidation(functionName: String, jsonRequest: [String:String]) -> Void {
        var lambdaResponse = false
        
        let lambda = AWSLambdaInvoker.default()
        lambda.invokeFunction(functionName, jsonObject: jsonRequest).continueWith(block: { (task) in
            if (task.result != nil){
                let json = task.result as! Dictionary<String, Any>
                let result = json["inUse"] ?? 0
                let respResult = String(describing: result)
                lambdaResponse = respResult.boolValue ?? false
                if lambdaResponse{
                    self.delegate?.showUsedEmailAlert()
                }
            }
            return nil
            })
    }
}
