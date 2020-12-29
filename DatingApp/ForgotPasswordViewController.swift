//
//  ForgotPasswordViewController.swift
//  JChat
//
//  Created by Laurent Azarnouche on 12/12/20.
//

import UIKit
import ProgressHUD
class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        setupEmailTextField()
        setupResetButton()
        
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        UserApi().resetPassword(email: emailTextField.text!) {
            self.view.endEditing(true)
            ProgressHUD.showSuccess(SUCCESS_EMAIL_RESET)
            self.navigationController?.popViewController(animated: true)
        } onError: { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }

        
    }
    
}
