//
//  LoginPageVC+Phone.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import FirebaseAuth

extension LoginPageVC:verifyViewdelegates
{
    //Delegates for handling button actions in verifyCodeView
    
    //MARK- Close Code Verification View
    
    func closeButtonPressed() {
        player.play()
        verifyView.isHidden = true
        verifyView.verifyTextResignResponder()
        phoneNumber = ""
    }
    
    //MARK:- Send Verification Code
    
    func sendVerificationCode()
    {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {[weak self] (verificationID, error) in
            guard let sSelf = self else {return}
            if let error = error {
                
                AlertManager.shared.showAlertError(forMessage: error.localizedDescription, desc: "")
                return
            }
            sSelf.verificationCode = verificationID!
        }
    }
    
    //MARK:- Resend Verification Code
    
    func resendCodeButtonPressed() {
        
        sendVerificationCode()
        
    }
    
    //MARK:- Signin after entering code
    
    func signInButtonPressed(code:String) {
        //Hide verifyview and clear text
        verifyView.isHidden = true
        view.endEditing(true)
        loginView.clearPhoneText()
        
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationCode,
            verificationCode: code)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                AlertManager.shared.showAlertError(forMessage: "Login Failed", desc: "")
                return
            }
            print("User is signed in ")
            // User is signed in
            // ...
            //Saving profile Info
            if let profile = authResult?.additionalUserInfo?.profile
            {
                let userModel = UserModel(with: profile)
                UserDefaults().savePropertyListindefaults(model: userModel, key: "profile")
            }
            UserDefaults.standard.set(true, forKey: "loginStatus")
            
            AlertManager.shared.showSuccess(forMessage: "Login Sucessfull", completion: {
                self.performSegue(withIdentifier: "home", sender: self)
            })
        }
    }
}
