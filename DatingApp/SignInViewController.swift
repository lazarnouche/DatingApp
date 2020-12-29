//
//  SignInViewController.swift
//  JChat
//
//  Created by Laurent Azarnouche on 12/12/20.
//

import UIKit
import ProgressHUD
class SignInViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordContainterView: UIView!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signInButton: UIButton!

    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
    }
    

    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func signInButtonDidTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.validateFields()
        self.signIn {
            (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).configureInitialViewController()
        } onError: { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
        
        
    }
    
    
    

    
}
