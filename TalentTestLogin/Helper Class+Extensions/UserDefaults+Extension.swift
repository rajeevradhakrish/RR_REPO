//
//  UserDefaults+Extension.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 26/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation

extension UserDefaults
{
    func savePropertyListindefaults(model:UserModel,key:String)
    {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(model), forKey:key)
    }
    
    func getPropertyListindefaults(key:String)->UserModel?
    {
        if let data = UserDefaults.standard.value(forKey:key) as? Data {
            let model = try? PropertyListDecoder().decode(UserModel.self, from: data)
            return model
        }
        return nil
    }
    
    
}
