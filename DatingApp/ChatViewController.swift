//
//  ChatViewController.swift
//  DatingApp
//
//  Created by Laurent Azarnouche on 12/18/20.
//

import UIKit
import MobileCoreServices
import AVFoundation
class ChatViewController: UIViewController {

    var imagePartner: UIImage!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    var partenerUsername: String!
    var placeholderLbl = UILabel()
    var partnerId: String!
    var picker = UIImagePickerController()
    
    @IBOutlet weak var mediaButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputContainer()
        setupNavigationBar()
        setupTableView()

        // Do any additional setup after loading the view.
    }

    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containView.addSubview(avatarImageView)
        let rightBarButton = UIBarButtonItem(customView: containView)
        navigationItem.rightBarButtonItem = rightBarButton
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: partenerUsername + "\n", attributes: [.font : UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black])
        attributed.append(NSAttributedString(string: "Active", attributes: [.font : UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.green]))
        topLabel.attributedText = attributed
        self.navigationItem.titleView = topLabel
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendBtnDidTapped(_ sender: UIButton) {
        if let text = inputTextView.text, text != "" {
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict: ["text": text as Any])
        }
    }
   
    func sendToFirebase(dict: Dictionary<String, Any>) {
            let date: Double = Date().timeIntervalSince1970
            var value = dict
            value["from"] = Api.User.currentUserId
            value["to"] = partnerId
            value["date"] = date
            value["read"] = true
            Api.Message.sendMessage(from: Api.User.currentUserId, to: partnerId, value: value)
//    
//            if let videoUrl = dict["videoUrl"] as? String, !videoUrl.isEmpty {
//                // send video notification
//                handleNotification(fromUid: Api.User.currentUserId, message: "[VIDEO]")
//            } else if let imageUrl = dict["imageUrl"] as? String, !imageUrl.isEmpty {
//                // send photo notification
//                handleNotification(fromUid: Api.User.currentUserId, message: "[PHOTO]")
//    
//            } else if let text = dict["text"] as? String, !text.isEmpty {
//                // send text notification
//                handleNotification(fromUid: Api.User.currentUserId, message: text)
//            }

        }

    
    
    
    @IBAction func mediaBtnDidTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Dating App", message: "Select source", preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
                
            } else {
                print("Unavailable")
            }
            
        }
        
        let library = UIAlertAction(title: "Choose an Image or a video", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
                
                self.present(self.picker, animated: true, completion: nil)
            } else {
                print("Unavailable")
            }
        }
        
        let videoCamera = UIAlertAction(title: "Take a video", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.picker.sourceType = .camera
                self.picker.mediaTypes = [String(kUTTypeMovie)]
                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                self.picker.videoMaximumDuration = 30
                self.present(self.picker, animated: true, completion: nil)
                
            } else {
                print("Unavailable")
            }
        }
        
  
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(cancel)
        alert.addAction(videoCamera)
        alert.addAction(library)
        
        present(alert, animated: true, completion: nil)
        alert.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
         }.first?.isActive = false
        
    
    }
    

    
    
}


