//
//  FacebookManager.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 03.12.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON

class FacebookManager {
    // shared suppose to be a instance of FacebookManager itself (Singleton)
    // for LoginManager() another let 
    static let shared = LoginManager()
    // current user can be here :)
    public class func getUserData(completion: @escaping () -> Void) {
        // for this case guard is better
        guard AccessToken.current != nil else { return }
        GraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(normal)"]).start(completionHandler: { (connection, result, error) in
            if error == nil {
                let json = JSON(result!)
                User.currentUser.setUser(json)
                completion()
            }
        })
    }
}
