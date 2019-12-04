//
//  LoginView.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 29.11.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//
import FBSDKLoginKit
import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var logoutFacebook: UIButton!
    
    var loginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard AccessToken.current != nil else { return }
        logoutFacebook.isHidden = true
        FacebookManager.getUserData(completion: {
            self.loginFacebook.setTitle("Вхід як \(String(describing: User.currentUser.name!))", for: .normal)// but name is String already, you are casting String? to String, just unwrap it
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //segues
        if AccessToken.current?.tokenString != nil && loginSuccess {
            performSegue(withIdentifier: "startViewID", sender: self)
        }
    }
    
    // MARK: - FACEBOOK BUTTONS
    
    @IBAction func facebookLogoutButton(_ sender: UIButton){
        FacebookManager.shared.logOut()
        User.currentUser.resetUser()
        logoutFacebook.isHidden = true
        loginFacebook.setTitle("Вхід через Facebook", for: .normal)
    }
    
    @IBAction func facebookLoginButton(_ sender: UIButton) {
        if AccessToken.current != nil {
            self.loginSuccess = true
            self.viewDidAppear(true) // don't call this method directly ever
        } else {
            FacebookManager.shared.logIn(permissions: ["public_profile", "email"], from: self, handler: { (result, error) in
                if error == nil {
                    FacebookManager.getUserData(completion: {
                        self.loginSuccess = true
                        self.viewDidAppear(true)
                    })
                }
            })
        }
    }
    
}

