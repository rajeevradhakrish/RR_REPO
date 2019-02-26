//
//  MockClassforJWTREST.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 26/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation

class MockClassforJWTREST
{
    static let shared=MockClassforJWTREST()
    
    //MOCK REST CALL for login
    
    func mockRESTAPI(payload:String)->Any?
    {
        //JWT Encoding of Parameters for Login
        
        let jwtEncodedStr = JWTHelper.shared.encodeJWT(issuer: Configuration.issuer, function: payload)
        
        //JWT Decoding should be done at server for authentication
        
        if let function = JWTHelper.shared.decodeJWTatServer(encodedStr: jwtEncodedStr)
        {
            if function == "login"
            {
                if let profile = UserDefaults().getPropertyListindefaults(key: "profile")
                {
                    print(profile)
                    return profile
                }
            }
        }
        return nil
    }
    
    
    //Check Login status /MOCK
    
    func isAlreadyLogin()->Bool
    {
        return UserDefaults.standard.bool(forKey: "loginStatus")
    }
    
    
}
