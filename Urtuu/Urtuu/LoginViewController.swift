//
//  LoginViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/12/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

@objc protocol LoginViewControllerDelegate {
    func didLoginWithSuccess(loginView: LoginViewController)
    optional func loginFailed()
}

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up FBSDKLoginButton
        fbLoginButton.layer.cornerRadius = 10
        fbLoginButton.readPermissions = ["email","user_photos"]
        fbLoginButton.delegate = self
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FBSDKLoginButton Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            println(error)
        } else if result.isCancelled {
            // handle cancellation
        } else {
            if result.grantedPermissions.contains("email") {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(Constants.userLoggedInValueOK, forKey: Constants.userLoggedInKey)
                userDefaults.synchronize()
                if let delegate = self.delegate {
                    delegate.didLoginWithSuccess(self)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // not needed, but good when testing
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: Constants.userLoggedInKey)
        defaults.synchronize()
    }
}
