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
    static let shared = LoginManager()
    
    public class func getUserData(completion: @escaping () -> Void) {
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(normal)"]).start(completionHandler: { (connection, result, error) in
            if error == nil {
                let json = JSON(result!)
                User.currentUser.setUser(json)
                completion()
            }
            })
        }
    }
}
