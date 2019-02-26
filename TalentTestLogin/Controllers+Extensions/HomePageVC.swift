//
//  HomePageVC.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 25/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    
    let messageLabel = UILabel()
    let logoutButton = UIButton()
    
    var profileModel:UserModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //MOCK CALL for profile data used JWT authentication
        getProfileData()
        //Setup UP and its constraints
        setupUI()
        setupConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    private func getProfileData()
    {
        let requestStr = "login"
        if let profile = MockClassforJWTREST.shared.mockRESTAPI(payload: requestStr) as? UserModel
        {
            print(profile)
            profileModel = profile
        }
    }
    
    private func setupUI()
    {
        title = "Home"
        messageLabel.text = """
        Hi \(profileModel.name)
        You are loged in to Talent Test
        """
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "AvenirNext", size: 12)
        messageLabel.textColor = UIColor.themeColor
        messageLabel.textAlignment = .center
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setBackgroundImage(UIImage(named: "resendButtonBg.png"), for: .normal)
        
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        view.addSubview(messageLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints()
    {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        messageLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.044).isActive = true
    }
    //MARK:- Logout User
    
    @objc func logOut()
    {
        UserDefaults.standard.set(false, forKey: "loginStatus")
        navigationController?.popViewController(animated: true)
    }
}
