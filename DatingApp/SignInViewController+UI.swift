//
//  SignInViewController+UI.swift
//  JChat
//
//  Created by Laurent Azarnouche on 12/12/20.
//

import UIKit
import ProgressHUD

extension SignInViewController {
    
    func setupTitleLabel() {
        let title = "Sign In"
        
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 28)!,
                                                                                   NSAttributedString.Key.foregroundColor : UIColor.black                                                                      ])
        
        titleTextLabel.attributedText = attributedText
    }
    
    
    func setupEmailTextField() {
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        emailTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        emailTextField.attributedPlaceholder = placeholderAttr
        emailTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupPasswordTextField() {
        passwordContainterView.layer.borderWidth = 1
        passwordContainterView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        passwordContainterView.layer.cornerRadius = 3
        passwordContainterView.clipsToBounds = true
        
        passwordTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = placeholderAttr
        passwordTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupSignInButton() {
        signInButton.setTitle("Sign In", for: UIControl.State.normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = UIColor.black
        signInButton.layer.cornerRadius = 5
        signInButton.clipsToBounds = true
        signInButton.setTitleColor(.white, for: UIControl.State.normal)
    }
    
    func setupSignUpButton() {
        
        let attributedText = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                                                                                                        NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)                                                                      ])
        let attributedSubText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
                                                                                          NSAttributedString.Key.foregroundColor : UIColor.black                                                                     ])
        attributedText.append(attributedSubText)
        signUpButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        
    }
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show("Loading...")
        Api.User.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) {
            onSuccess()
            ProgressHUD.dismiss()
        } onError: { (errorMessage) in
            onError(errorMessage)
        }
  
        
    }
    
    
    func validateFields() {

        guard let email = self.emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)

            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)

            return
        }

    }
    
 
}
