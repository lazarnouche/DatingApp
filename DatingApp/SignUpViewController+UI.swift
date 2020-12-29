//
//  SignUpViewController+UI.swift
//  JChat
//
//  Created by Laurent Azarnouche on 12/12/20.
//

import UIKit
import ProgressHUD
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ZIPFoundation
extension SignUpViewController{
    
    func setupTitleLabel() {
        let title = "Sign Up"
        
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 28)!,
                                                                                   NSAttributedString.Key.foregroundColor : UIColor.black                                                                      ])
        
        titleTextLabel.attributedText = attributedText
    }
    
    func setupAvatar() {
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func updateAvatarImage(_ notification: Notification) {
        avatar.image = MaskApi.imagewithMask
        image = MaskApi.imagewithMask

       
    }
    @objc func presentPicker(){
        
        let storyboard =  UIStoryboard(name: "Welcome", bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAvatarImage(_:)), name: Notification.Name(rawValue: "updateAvatarImage"), object: nil)

        let MaskVC = storyboard.instantiateViewController(withIdentifier: "MaskVC")
        as! MaskViewController


        
//        ChatVC.partnerId = cell.user.uid
//        ChatVC.imagePartner = cell.avatar.image
//        ChatVC.partenerUsername = cell.usernameLbl.text
        self.navigationController?.pushViewController(MaskVC, animated: true)
        

        
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = true
//        picker.delegate = self
//        self.present(picker, animated: true, completion: nil)
        
    }
    
    func setupFullNameTextField() {
        
        fullnameContainerView.layer.borderWidth = 1
        fullnameContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        fullnameContainerView.layer.cornerRadius = 3
        fullnameContainerView.clipsToBounds = true
        
        fullnameTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        fullnameTextField.attributedPlaceholder = placeholderAttr
        fullnameTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
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
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        
        passwordTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = placeholderAttr
        passwordTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupSignUpButton() {
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signUpButton.backgroundColor = UIColor.black
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        signUpButton.setTitleColor(.white, for: UIControl.State.normal)
    }
    
    func setupSignInButton() {
        
        let attributedText = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                                                                                                          NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)                                                                      ])
        let attributedSubText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
                                                                                          NSAttributedString.Key.foregroundColor : UIColor.black                                                                     ])
        attributedText.append(attributedSubText)
        signInButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show("Loading...")
        Api.User.signUp(withUsername: self.fullnameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, image: self.image, onSuccess: {
            onSuccess()
            ProgressHUD.dismiss()
        }) {(errorMessage) in
            onError(errorMessage)
        }
  
        
        
    }
        
    func validateFields() {
    
        guard let username = self.fullnameTextField.text, !username.isEmpty else {
            print("user name is empty")
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return
        }
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


extension SignUpViewController: UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            image = imageSelected
            avatar.image = imageSelected
            
        }
        
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            image = imageOriginal
            avatar.image = imageOriginal
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
}

extension FileManager {

    func directoryExists(atUrl url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = self.fileExists(atPath: url.path, isDirectory:&isDirectory)
        return exists && isDirectory.boolValue
    }

}
extension SignUpViewController{
    
    

    func _downloadMasks(from item: StorageReference, folderUrl: URL, fileUrl: URL){
        let fileManager = FileManager()
        item.write(toFile: fileUrl) { (url, error) in
            if error != nil {
                print("ERROR FOUND: \(error!)")
            }else{
                print("before \(Thread.isMainThread)")
                let queue = DispatchQueue(label: "work_queue")
                queue.async{
                    do {
                        
                        
                        try fileManager.unzipItem(at: url!, to: folderUrl)
                        
                        let name = (url!.lastPathComponent as NSString).deletingPathExtension
                        let pathToFolder = URL(string: "\(folderUrl.absoluteString)/\(name)/\(name).scn")
                        
                        
                        print("is main thread \(Thread.isMainThread)")
                        print("current thread is \(Thread.current)")
                        
                        MaskApi.maskRemoteURL!.append(pathToFolder!)
                        
                        
                        
                    } catch {
                        print("Extraction of ZIP archive failed with error:\(error)")
                    }
                }
                
                }
            }
        }

//    func downloadMasks(){
//        let queue = DispatchQueue(label: "work_queue")
//        queue.async{
//            print("is main thread \(Thread.isMainThread)")
//            print("current thread is \(Thread.current)")
//        }
//    }
    func downloadMasks(){
        
        let ref = Ref().storageRoot.child("Mask")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let sourceDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        
        ref.listAll { (result, error) in
            if let error = error{
                print(error)
            }
            print("result result \(result)")
            for item in result.items{
                print("item itm \(item)")
                item.downloadURL { (dataURL, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    if let url = dataURL {
//                        let masknameurl = url.lastPathComponent
                        let fileUrl = sourceDirectory.appendingPathComponent("Data/\(url.lastPathComponent)")
                        let masknameurl = (url.lastPathComponent as NSString).deletingPathExtension
                        let targetUrl = sourceDirectory.appendingPathComponent("Data/\(masknameurl)")
                        if url.pathExtension == "zip"{
//                            let queue = DispatchQueue(label: "work_queue")
//                            queue.async{
                                
                            self._downloadMasks(from: item, folderUrl: targetUrl, fileUrl: fileUrl)
                                
//                            }
                            
//                            UserData.masktextureRemoteURL!.append(targetUrl)
                  
                            
                        }
       
                    }
                    
                }
            }
            
        }


       
    }

    func downloadMasksacnlaknc(){

        let modelPath = Ref().storageRoot.child("Mask/GattoRombi.scn")


        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
         let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
         let targetUrl = tempDirectory.appendingPathComponent("/JJJJ/GattoRombi.scn")
        print(targetUrl)

         modelPath.write(toFile: targetUrl) { (url, error) in
                      if error != nil {
                          print("ERROR: \(error!)")
                      }else{
                          print(url!)
                      }
                 }

         MaskApi.maskRemoteURL = [targetUrl]

    }
    
    
    

}

extension SignUpViewController{
    
    func showSpinner(){
        
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(red: 0.7, green: 0.5, blue: 0.7, alpha: 0.7)
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = aView!.center
        activityView.startAnimating()
        aView?.addSubview(activityView)
        self.view.addSubview(aView!)
        
    }
    
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
        
        
        
    }
}
