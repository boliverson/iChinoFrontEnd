//
//  LoginUser.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/6/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation

class LoginUser: LambdaBase {
    
    func loginRequest(email: String, password: String) -> Void {
        let loginData: [String: String] = ["email" : email, "password" : password]
        self.serverValidation(functionName: "loginUser", jsonRequest: loginData, type: 1)
    }
}
