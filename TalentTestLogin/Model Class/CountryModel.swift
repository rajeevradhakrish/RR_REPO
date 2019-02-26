//
//  CountryModel.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 25/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation

struct CountryModel
{
    var name = ""
    var code = ""
    var flag = ""
    
    internal init(with details:[String:Any])
    {
        if let name = details["name"] as? String
        {
            self.name = name
        }
        if let code = details["callingCodes"] as? [String]
        {
            self.code = code[0]
        }
        if let flag = details["flag"] as? String
        {
            self.flag = flag
        }
    }
}
