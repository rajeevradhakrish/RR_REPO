//
//  VerificyCodeView.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 25/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit

protocol verifyViewdelegates
{
    func closeButtonPressed()
    func resendCodeButtonPressed()
    func signInButtonPressed(code:String)
}

class VerificyCodeView: UIView {
    
    let verifyLabel=UILabel()
    let closeButton = UIButton()
    let closeImageiew = UIImageView()
    let verifyCodeText = UITextField()
    let continueButton = UIButton()
    let resendButton = UIButton()
    
    var delegate:verifyViewdelegates?
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setupUI()
        setupConstraint()
    }
    
    private func setupUI()
    {
        backgroundColor = UIColor.themeColor
        verifyLabel.font = UIFont(name: "AvenirNext", size: 10)
        verifyLabel.numberOfLines = 0
        verifyLabel.textColor = UIColor.white
        verifyLabel.textAlignment = .center
        verifyLabel.text = """
        we send a verification code to your
        phone number.Enter it below.
        """
        
        closeImageiew.image = UIImage(named: "close.png")
        closeImageiew.contentMode = .scaleAspectFit
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        verifyCodeText.font = UIFont(name: "AvenirNext", size: 20)
        verifyCodeText.textColor = UIColor.themeColor
        verifyCodeText.attributedPlaceholder = NSAttributedString(string: "Enter Code",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        verifyCodeText.borderStyle = .roundedRect
        verifyCodeText.textAlignment = .center
        verifyCodeText.keyboardType = .numberPad
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setBackgroundImage(UIImage(named: "resendButtonBg.png"), for: .normal)
        
        resendButton.setTitle("Resend", for: .normal)
        resendButton.setBackgroundImage(UIImage(named: "resendButtonBg.png"), for: .normal)
        
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        resendButton.addTarget(self, action: #selector(resendButtonPressed), for: .touchUpInside)
        
        
        addSubview(verifyLabel)
        addSubview(closeImageiew)
        addSubview(closeButton)
        addSubview(verifyCodeText)
        addSubview(continueButton)
        addSubview(resendButton)
    }
    func verifyTextFirstResponder()
    {
        verifyCodeText.becomeFirstResponder()
    }
    func verifyTextResignResponder()
    {
        verifyCodeText.resignFirstResponder()
    }
    
   
    
    private func setupConstraint()
    {
        verifyLabel.translatesAutoresizingMaskIntoConstraints = false
        verifyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        verifyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        verifyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        verifyLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.09).isActive = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        closeButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.13).isActive = true
        
        closeImageiew.translatesAutoresizingMaskIntoConstraints = false
        closeImageiew.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
        closeImageiew.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        closeImageiew.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 0.50).isActive = true
        closeImageiew.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 0.50).isActive = true
        
        verifyCodeText.translatesAutoresizingMaskIntoConstraints = false
        verifyCodeText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        verifyCodeText.topAnchor.constraint(equalTo: verifyLabel.bottomAnchor, constant: 40).isActive = true
        verifyCodeText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
        verifyCodeText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.trailingAnchor.constraint(equalTo: centerXAnchor,constant:-10).isActive = true
        continueButton.topAnchor.constraint(equalTo: verifyCodeText.bottomAnchor, constant: 20).isActive = true
        continueButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.24).isActive = true
        continueButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.044).isActive = true
        
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendButton.leadingAnchor.constraint(equalTo: centerXAnchor,constant:10).isActive = true
        resendButton.topAnchor.constraint(equalTo: verifyCodeText.bottomAnchor, constant: 20).isActive = true
        resendButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.24).isActive = true
        resendButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.044).isActive = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func closeButtonPressed()
    {
        delegate?.closeButtonPressed()
    }
    @objc func continueButtonPressed()
    {
        delegate?.signInButtonPressed(code:verifyCodeText.text!)
    }
    
    @objc func resendButtonPressed()
    {
        delegate?.resendCodeButtonPressed()
    }
    
}
