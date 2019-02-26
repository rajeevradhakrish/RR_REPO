//
//  JWTHelper.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 26/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import JWT

class JWTHelper
{
    static let shared=JWTHelper()
    
    func encodeJWT(issuer:String,function:String)->String
    {
        var claims = ClaimSet()
        claims.issuer = issuer
        claims.issuedAt = Date()
        claims["custom"] = function
        
        return JWT.encode(claims: claims, algorithm: .hs256(Configuration.secretKeyJWT.data(using: .utf8)!))
    }
    
    func decodeJWTatServer(encodedStr:String)->String?
    {
        do {
            let claims: ClaimSet = try JWT.decode(encodedStr, algorithm: .hs256(Configuration.secretKeyJWT.data(using: .utf8)!))
            
            if let function = claims["custom"] as? String,claims.issuer == Configuration.issuer
            {
                
                return function
            }
            
        } catch {
            print("Failed to decode JWT: \(error)")
            return nil
        }
        return nil
    }
    
}
