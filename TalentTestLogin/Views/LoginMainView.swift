//
//  LoginMainView.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit

protocol LoginMainViewDelegates
{
    func countryCodeButtonPressed()
    func faceBookButtonPressed()
    func googleButtonPressed()
    func signUpPressed(phone:String)
}
class LoginMainView: UIView {
    
    var imageUrl: String? {
        didSet {
            countryFlagImg.loadSVGImage(url: imageUrl!)
            setNeedsUpdateConstraints()
        }
    }
    
    var countryCode:String?
    {
        didSet{
            countryCodeLabel.text = countryCode
            setNeedsUpdateConstraints()
        }
    }
    
    let titleLabel = UILabel()
    let titleImageView = UIImageView()
    let bgImagePhone = UIImageView()
    let countryCodeButton = UIButton()
    let countryFlagImg = UIImageView()
    let countryCodeLabel = UILabel()
    let phoneText = UITextField()
    let signupPhoneButton = UIButton()
    let seperatorImg = UIImageView()
    let facebookButton = UIButton()
    let googleButton = UIButton()
    let termsLabel = UILabel()
    var delegate:LoginMainViewDelegates!
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setupUI()
        setupConstraints()
    
    }
    
    private func setupUI()
    {
        titleImageView.image = UIImage(named: "dance.png")
        titleImageView.contentMode = .scaleAspectFit
        bgImagePhone.image = UIImage(named: "PhoneBg")
        bgImagePhone.alpha = 0.3
        bgImagePhone.contentMode = .scaleAspectFit
        countryFlagImg.image = UIImage(named: "usaFlag.png")
        countryFlagImg.contentMode = .scaleAspectFit
        countryCodeLabel.text = "+1"
        countryCodeLabel.font = UIFont(name: "AvenirNext", size: 6.0)
        countryCodeLabel.textColor = UIColor.white
        countryCodeButton.addTarget(self, action: #selector(countryCodeButtonPressed), for: .touchUpInside)
        phoneText.textColor = UIColor.white
        phoneText.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        phoneText.keyboardType = .numberPad
        signupPhoneButton.setBackgroundImage(UIImage(named: "signupPhone.png"), for: .normal)
        signupPhoneButton.setTitle("Signup/Login with phone", for: .normal)
        seperatorImg.image = UIImage(named: "seperator.png")
        seperatorImg.contentMode = .scaleAspectFit
        facebookButton.setBackgroundImage(UIImage(named: "facebook.png"), for: .normal)
        googleButton.setBackgroundImage(UIImage(named: "google.png"), for: .normal)
        
        facebookButton.addTarget(self, action: #selector(faceBookButtonPressed), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        signupPhoneButton.addTarget(self, action: #selector(signUPPhonePressed), for: .touchUpInside)
        
        termsLabel.text = """
        Login means you agree to our
        Terms of Service and Privacy Policy
        """
        termsLabel.numberOfLines = 0
        termsLabel.font = UIFont(name: "AvenirNext", size: 15.0)
        termsLabel.textColor = UIColor.lightGray
        termsLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(titleImageView)
        addSubview(bgImagePhone)
        addSubview(countryCodeButton)
        addSubview(countryFlagImg)
        addSubview(countryCodeLabel)
        addSubview(phoneText)
        addSubview(seperatorImg)
        addSubview(facebookButton)
        addSubview(googleButton)
        addSubview(signupPhoneButton)
        addSubview(termsLabel)
        
    }
    private func setupConstraints()
    {
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive=true
        titleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.104).isActive=true
        titleImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.533).isActive=true
        
        bgImagePhone.translatesAutoresizingMaskIntoConstraints = false
        bgImagePhone.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bgImagePhone.centerYAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 60).isActive = true
        bgImagePhone.widthAnchor.constraint(equalToConstant: width-20).isActive = true
        bgImagePhone.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.067).isActive = true
        
        countryCodeButton.translatesAutoresizingMaskIntoConstraints = false
        countryCodeButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        countryCodeButton.centerYAnchor.constraint(equalTo: bgImagePhone.centerYAnchor).isActive = true
        countryCodeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.26).isActive = true
        countryCodeButton.heightAnchor.constraint(equalTo: bgImagePhone.heightAnchor).isActive = true
        
        countryFlagImg.translatesAutoresizingMaskIntoConstraints = false
        countryFlagImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive=true
        countryFlagImg.centerYAnchor.constraint(equalTo: bgImagePhone.centerYAnchor).isActive = true
        countryFlagImg.widthAnchor.constraint(equalTo: bgImagePhone.heightAnchor, multiplier: 0.60).isActive = true
        countryFlagImg.heightAnchor.constraint(equalTo: bgImagePhone.heightAnchor, multiplier: 0.60).isActive = true
        
        countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCodeLabel.leadingAnchor.constraint(equalTo: countryFlagImg.trailingAnchor, constant: 3).isActive=true
        countryCodeLabel.centerYAnchor.constraint(equalTo: bgImagePhone.centerYAnchor).isActive = true
        countryCodeLabel.widthAnchor.constraint(equalTo: countryCodeButton.widthAnchor, multiplier: 0.70).isActive = true
        countryCodeLabel.heightAnchor.constraint(equalTo: bgImagePhone.heightAnchor, multiplier: 0.60).isActive = true
        
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        phoneText.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 10).isActive=true
        phoneText.centerYAnchor.constraint(equalTo: bgImagePhone.centerYAnchor).isActive = true
        phoneText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.70).isActive = true
        phoneText.heightAnchor.constraint(equalTo: bgImagePhone.heightAnchor, multiplier: 0.80).isActive = true
        
        signupPhoneButton.translatesAutoresizingMaskIntoConstraints = false
        signupPhoneButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupPhoneButton.centerYAnchor.constraint(equalTo: bgImagePhone.bottomAnchor, constant: 40).isActive = true
        signupPhoneButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.733).isActive = true
        signupPhoneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
        
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        termsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        termsLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.733).isActive = true
        termsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.074).isActive = true
        
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 30).isActive = true
        googleButton.bottomAnchor.constraint(equalTo: termsLabel.topAnchor, constant: -20).isActive = true
        googleButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        googleButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -30).isActive = true
        facebookButton.bottomAnchor.constraint(equalTo: termsLabel.topAnchor, constant: -20).isActive = true
        facebookButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        
        seperatorImg.translatesAutoresizingMaskIntoConstraints = false
        seperatorImg.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorImg.bottomAnchor.constraint(equalTo: facebookButton.topAnchor, constant: -5).isActive = true
        seperatorImg.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.94).isActive = true
        seperatorImg.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
        
    }
    
    func clearPhoneText()
    {
        phoneText.text = ""
    }
    
    //MARK:- Handling Button Actions
    
    @objc func countryCodeButtonPressed()
    {
        delegate.countryCodeButtonPressed()
    }
    
    @objc func faceBookButtonPressed()
    {
        delegate.faceBookButtonPressed()
    }
    
    @objc func googleButtonPressed()
    {
        delegate.googleButtonPressed()
    }
    
    @objc func signUPPhonePressed()
    {
        delegate.signUpPressed(phone: phoneText.text!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
