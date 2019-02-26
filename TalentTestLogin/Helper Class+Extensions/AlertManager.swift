//
//  AlertManager.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import SCLAlertView
class AlertManager{
    
    static let shared=AlertManager()
    private func initializedView()->SCLAlertView
    {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        return SCLAlertView(appearance: appearance)
    }
    public func showAlertError(forMessage message:String,desc:String)
    {
        let view=initializedView()
        view.addButton("OK", action: {})
        view.showError("Error", subTitle: message)
        print(desc)
    }
    
    public func showSuccess(forMessage message:String,completion: (()->Void)?)
    {
        let view=initializedView()
        view.addButton("OK", action: {
            completion?()
        })
        view.showSuccess("ForeCast", subTitle: message)
    }
}
