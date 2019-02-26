//
//  ActivityIndicator.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
class ActivityIndicator {
    static let shared=ActivityIndicator()
    var activityIndicator:NVActivityIndicatorView
    init() {
        let bounds=UIScreen.main.bounds
        let frame=CGRect(x: (bounds.size.width/2)-25, y: bounds.size.height/2-25, width: 50, height: 50)
        self.activityIndicator=NVActivityIndicatorView(frame: frame, type: .lineScalePulseOut, color: .themeColor, padding: 0)
        
        
    }
    func showLoader(onView view:UIView)
    {
        activityIndicator.startAnimating()
        let parentView=UIView(frame: UIScreen.main.bounds)
        parentView.backgroundColor = UIColor.clear
        parentView.addSubview(activityIndicator)
        view.addSubview(parentView)
    }
    func removeLoader()
    {
        activityIndicator.stopAnimating()
        let view=activityIndicator.superview
        view?.removeFromSuperview()
    }
    
    func showLoaderWithText()
    {
        let activityData = ActivityData(size: CGSize(width: 100, height: 100), message: "Generating Registration Code", messageFont: UIFont.systemFont(ofSize: 15) , type: .lineScalePulseOut, color: .white, padding: 0, displayTimeThreshold: 0, minimumDisplayTime: 10, backgroundColor: .clear, textColor: .white)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func removeLoaderWithText()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    
    
}
