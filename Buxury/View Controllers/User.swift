//
//  User.swift
//  Buxury
//
//  Created by Anique Davla on 11/26/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import Foundation
class User {
    
    var firstName: String
    var lastName: String
    var email: String
    var userID: String
    
    init (_ firstName:String ,_ lastName:String ,_ email:String, _ userID:String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userID = userID
    }
}
