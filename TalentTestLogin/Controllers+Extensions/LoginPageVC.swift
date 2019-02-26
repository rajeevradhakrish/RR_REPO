//
//  LoginPageVC.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginPageVC: UIViewController {
    
    var playerView = UIView()
    var player:RTMPPlayer!
    var logoImgView:UIImageView!
    var shadowView = UIView()
    let loginView = LoginMainView()
    let verifyView = VerificyCodeView()
    var phoneNumber = ""
    var countryCode = "+1"
    var verificationCode = ""
    var selectedCountry:CountryModel!
    
    //MARK:- View layout Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        setupConstraints()
        setUpPlayer()
        
        //Google Signin
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        loadShadowView()
        
        if MockClassforJWTREST.shared.isAlreadyLogin()
        {
            performSegue(withIdentifier: "home", sender: self)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if let country = selectedCountry
        {
            loginView.imageUrl = country.flag
            loginView.countryCode = country.code
            countryCode = "+\(country.code)"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player.stop()
    }
    
    //MARK:- Private Functions
    
    @objc func viewTapped()
    {
        self.view.endEditing(true)
    }
    
    private func setupUI()
    {
        logoImgView = UIImageView(image: UIImage(named: "logo"))
        playerView.backgroundColor = UIColor.themeColor
        verifyView.isHidden = true
        view.addSubview(logoImgView)
        view.addSubview(playerView)
        view.addSubview(shadowView)
        view.addSubview(loginView)
        view.addSubview(verifyView)
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        loginView.addGestureRecognizer(tapGest)
        loginView.delegate = self
        verifyView.delegate = self
    }
    
    private func loadShadowView()
    {
        self.loginView.isHidden = true
        self.playerView.isHidden = true
        self.shadowView.isHidden = true
        self.shadowView.alpha = 0.7
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+7, execute:
            {
                self.shadowView.backgroundColor = UIColor.black
                self.view.backgroundColor = UIColor.black
                self.playerView.isHidden = false
                self.loginView.isHidden = false
                self.shadowView.isHidden = false
                
        })
        
    }
    private func setUpPlayer()
    {
        player = RTMPPlayer(with: playerView)
    }
    
    private func setupConstraints()
    {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        // 2
        playerView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,constant:10).isActive = true
        playerView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,constant:-10).isActive = true
        playerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -30).isActive = true
        // 3
        playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20)
        playerView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1).isActive = true
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        // 2
        shadowView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,constant:10).isActive = true
        shadowView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,constant:-10).isActive = true
        shadowView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -30).isActive = true
        // 3
        shadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20)
        shadowView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1).isActive = true
        
        verifyView.translatesAutoresizingMaskIntoConstraints = false
        // 2
        verifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        verifyView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        verifyView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        verifyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        logoImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        logoImgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        logoImgView.widthAnchor.constraint(equalToConstant: view.frame.width/3.125).isActive=true
        logoImgView.heightAnchor.constraint(equalToConstant: view.frame.width/3.125).isActive=true
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        // 2
        loginView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        loginView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        // 3
        loginView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        
    }
}

extension LoginPageVC:LoginMainViewDelegates
{
    func countryCodeButtonPressed() {
        
        player.stop()
        
        performSegue(withIdentifier: "search", sender: self)
        
    }
    func faceBookButtonPressed() {
        player.stop()
        facebookLoginClicked()
        
    }
    func googleButtonPressed() {
        player.stop()
        googleSigninPressed()
        
    }
    func signUpPressed(phone:String) {
        
        player.stop()
        
        if phone.count > 6 && phone.count < 11
        {
            verifyView.isHidden = false
            verifyView.verifyTextFirstResponder()
            phoneNumber = countryCode + phone
            print(phoneNumber)
            sendVerificationCode()
        }
        else
        {
            AlertManager.shared.showAlertError(forMessage: "Please Enter a Valid Phone Number", desc: "")
        }
    }
    
}
