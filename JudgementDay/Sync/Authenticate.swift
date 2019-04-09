//
//  Authenticate.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/3/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

class Authenticate: LambdaBase {
    
    func validateEmail(email: String) -> Void {
        let userEmail: [String: String] = ["email" : email]
        self.serverValidation(functionName: "checkIfEmailInUse", jsonRequest: userEmail, type: 0)
    }
}
