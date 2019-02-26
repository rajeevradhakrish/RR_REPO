//
//  LoginPageVC+Facebook.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import FacebookLogin
import FBSDKCoreKit

extension LoginPageVC
{
    func facebookLoginClicked()
    {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self, completion: {loginresult in
            switch loginresult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
                FBSDKGraphRequest(graphPath:"me", parameters: ["fields" : "email,name,picture"]).start(completionHandler: { (connection, result, error) in
                    if error == nil {
                        if let profile = result as? [String : Any]
                        {
                            let userModel = UserModel(with: profile)
                            UserDefaults().savePropertyListindefaults(model: userModel, key: "profile")
                        }
                    } else {
                        print("Error Getting Info \(String(describing: error))");
                    }
                })
                UserDefaults.standard.set(true, forKey: "loginStatus")
                AlertManager.shared.showSuccess(forMessage: "Login Sucessfull", completion: {
                    self.performSegue(withIdentifier: "home", sender: self)
                })
                
            }
        })
    }
}
