//
//  LoginPageVC+Google.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

extension LoginPageVC:GIDSignInDelegate,GIDSignInUIDelegate
{
    //MARK: Call Google Sign in
    func googleSigninPressed()
    {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:- Signin delegate which is called when Signin
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            // ...
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print(error)
                return
            }
            
            //Saving the user profile
            
            if let profile = authResult?.additionalUserInfo?.profile
            {
                let userModel = UserModel(with: profile)
                UserDefaults().savePropertyListindefaults(model: userModel, key: "profile")
            }
            print("user signed in")
            // User is signed in
            // ...
            UserDefaults.standard.set(true, forKey: "loginStatus")
            AlertManager.shared.showSuccess(forMessage: "Login Sucessfull", completion: {
                self.performSegue(withIdentifier: "home", sender: self)
            })
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
