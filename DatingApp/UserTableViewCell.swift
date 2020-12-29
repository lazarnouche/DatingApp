//
//  UserTableViewCell.swift
//  DatingApp
//
//  Created by Laurent Azarnouche on 12/17/20.
//

import UIKit
class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    var user: User!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(_ user: User){
        self.user = user
        self.usernameLbl.text = user.username
        self.statusLbl.text = user.status
        self.avatar.loadImage(user.profileImageUrl)
        
    }

}
