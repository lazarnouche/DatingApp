//
//  UserApi.swift
//  JChat
//
//  Created by DuyetTran on 2/12/19.
//  Copyright © 2019 zero2launch. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import ProgressHUD
import FirebaseStorage
import FirebaseDatabase
//import GoogleSignIn

class UserApi {
    
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    func signIn(email: String, password: String,onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil{
                onError(error!.localizedDescription)
            }else{
                onSuccess()
            }
            
        }
    }
    
    func signUp (withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        guard let imageSelected = image else{
            ProgressHUD.showError(ERROR_EMPTY_PHOTO)
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)  else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil{
                onError(error!.localizedDescription)
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult{
                let dict: Dictionary<String,Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email ?? "default value",
                    USERNAME: username,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome to DatingApp",
                ]
                

                let storageProfileRef = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                
                StorageService.savePhoto(username: username, uid: authData.user.uid, data: imageData, metadata: metadata, storageProfileRef: storageProfileRef, dict: dict, onSuccess: {
                    onSuccess()
                }) { (errorMessage) in
                     onError(errorMessage)
                }

            }
        }
    }
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void ){
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil{
                onSuccess()

            }else{
                onError(error!.localizedDescription)
                
            }
        
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            ProgressHUD.showError(error.localizedDescription)
            return
        }
        
        (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).configureInitialViewController()
        
    }
    
    
    func observeUsers(onSuccess: @escaping(UserCompletion)){
        
        
        Ref().databaseUsers.observe(.childAdded) { (snapchot) in
            if let dict = snapchot.value as? Dictionary<String,Any>{
                if let user = User.tranformUser(dict: dict){
                    onSuccess(user)
                }
                
            }
        }
        
    }
    
    
}

typealias UserCompletion = (User) -> Void
