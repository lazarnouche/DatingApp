    //
//  SignUpViewController.swift
//  JChat
//
//  Created by Laurent Azarnouche on 12/10/20.
//

import UIKit
import ProgressHUD
class SignUpViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullnameContainerView: UIView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var image: UIImage? = nil
    var aView: UIView? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        

        // Do any additional setup after loading the view.
    }
    func setupUI(){
        setupTitleLabel()
        setupAvatar()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        downloadMasks()


//        showSpinner()
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func signUpButtonDidTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.validateFields()
        self.signUp {
            (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).configureInitialViewController()
        } onError: { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }


    }
}
    

