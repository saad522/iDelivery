//
//  User.swift
//  iDelivery
//
//  Created by mac on 11/11/20.
//

import Foundation

struct User {
    let fullName     : String
    let city         : String
    let phone        : String
    let profileImage : String
    let userId       : String
    let password     : String
    let email        : String
    let price        : String
    let retruns      : String
    let stock        : String
    let transport    : Int
   
    init(dectionary : [String : Any]) {
        self.fullName     = dectionary["fullName"] as? String ?? ""
        self.email        = dectionary["email"] as? String ?? ""
        self.city         = dectionary["city"] as? String ?? ""
        self.userId       = dectionary["userId"] as? String ?? ""
        self.profileImage = dectionary["profileImage"] as? String ?? ""
        self.phone        = dectionary["phone"] as? String ?? "0"
        self.password     = dectionary["password"] as? String ?? ""
        self.price        = dectionary["price"] as? String ?? "0"
        self.retruns      = dectionary["retruns"] as? String ?? "0"
        self.stock        = dectionary["stock"] as? String ?? "0"
        self.transport    = dectionary["transport"] as? Int ?? 0
    }
}


