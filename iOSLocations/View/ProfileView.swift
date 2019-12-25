//
//  ProfileView.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 03.12.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = User.currentUser.name
        emailLabel.text = User.currentUser.email
        imageView.image = try! UIImage(data: Data(contentsOf: URL(string: User.currentUser.pictureURL!)!))// create some func for creating UIImage from url
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.clipsToBounds = true
    }
    // segues, i'm encouraging you not to use them at all
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "clientLogout" {
            FacebookManager.shared.logOut()
            User.currentUser.resetUser()
        }
    }
    
}
