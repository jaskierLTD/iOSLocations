//
//  User.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 03.12.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//

import Foundation
import SwiftyJSON
// also struct , code style
struct User {
    var name: String?
    var email: String?
    var pictureURL: String?
    static let currentUser = User() // better to move it to some manager, here it's useless
    
    // JsonDecoder can handle it without additional dependency
    func setUser(_ json: JSON) {
        self.name = json["name"].string
        self.email = json["email"].string
        
        let image = json["picture"].dictionary
        let imageData = image?["data"]?.dictionary
        self.pictureURL = imageData?["url"]?.string
    }
    
    func resetUser() {
        self.name = nil
        self.email = nil
        self.pictureURL = nil
    }
}
