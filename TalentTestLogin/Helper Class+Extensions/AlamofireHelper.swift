//
//  AlamofireHelper.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireHelper:NSObject
{
    // With Alamofire
    
    class func fetchRequest(urlString:String,parameters:[String:String]?,completion: @escaping ([[String: Any]]?) -> Void) {
        if isConnectedToInternet()
        {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            Alamofire.request(url,
                              method: .get,
                              parameters: parameters)
                .validate()
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        print("Error")
                        completion(nil)
                        return
                    }
                    
                    guard let value = response.result.value as? [[String: Any]] else {
                        print("Error fetching data")
                        completion(nil)
                        return
                    }
                    completion(value)
            }
        }
        else
        {
            AlertManager.shared.showAlertError(forMessage: "Please Connect to Internet Before Proceeding", desc: "")
            ActivityIndicator.shared.removeLoader()
        }
    }
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
