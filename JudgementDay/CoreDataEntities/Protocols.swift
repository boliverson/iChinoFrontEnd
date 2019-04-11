//
//  Protocols.swift
//  JudgementDay
//
//  Created by Ben Oliverson on 4/3/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import CoreData

protocol Uploadable: NSObject{
    var serverKey: Int64 {get set}
}

protocol LambdaBoolResponse {
    func showUsedEmailAlert() -> Void
    func userAuthenticationResponse(response: Bool, userId: Int64) -> Void
}
