//
//  UserModel.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 26/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
struct UserModel:Codable
{
    var name = ""
    var id = ""
    var email = ""
    var phone = ""
    
    internal init(with details:[String:Any])
    {
        if let name = details["name"] as? String
        {
            self.name = name
        }
        if let id = details["id"] as? String
        {
            self.id = id
        }
        if let email = details["email"] as? String
        {
            self.email = email
        }
    }
}
