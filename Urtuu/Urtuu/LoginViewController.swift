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
    
    let httpHelper = HTTPHelper()
    var delegate: LoginViewControllerDelegate?
    var loginWithFB: Bool = false
    var userEmail: String? = nil
    var currentUser: User!
    
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
                loginWithFB = true
                
                let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email"])
                graphRequest.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject?, error: NSError!) in
                    let resultDict = result as? NSDictionary as? [String: String]
                    println(3)
                    if let email = resultDict!["email"] {
                        if let fbId = resultDict!["id"] {
                            self.userEmail = email
                            let userDefaults = NSUserDefaults.standardUserDefaults()
                            
                            self.loginRequest(email, fbId: fbId)
                        }
                    }
                })
                println(2)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // not needed, but good when testing
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: Constants.userLoggedInKey)
        defaults.synchronize()
    }
    
    // MARK: - Urtu servers communication
    
    func loginRequest(email: String, fbId: String){
        let httpRequest = httpHelper.buildLoginRequest(email, fbId: fbId)
        httpHelper.sendRequest(httpRequest, completion: { (data:NSData!, error: NSError!) in
            
            if error != nil {
                // got an error, whatever
            }
            
            var error: NSError?
            let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as! NSDictionary 
            if response["error"] != nil {
                if self.loginWithFB {
                    // user not signed up, sign him up
                    let profile = FBSDKProfile.currentProfile()
                    if let email = self.userEmail {
                        let signUpRequest = self.httpHelper.buildSignUpRequest(email, fName: profile.firstName, lName: profile.lastName, fbId: profile.userID)
                        var response: NSURLResponse?
                        var error: NSError?
                        let data: NSData = NSURLConnection.sendSynchronousRequest(signUpRequest, returningResponse: &response, error: &error)!
                        let dataDict = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error) as! NSDictionary
                        if dataDict["error"] != nil {
                            // something happened during the sign up. Fix it
                        } else {
                            if let delegate = self.delegate {
                                delegate.didLoginWithSuccess(self)
                            }
                            self.updateCurrentUser(dataDict)
                        }
                    }
                } else {
                    // user entered wrong credentials
                    self.showLoginErrorAlert()
                }
            } else {
                self.updateUserDefaultsToLoggedIn()
                self.updateCurrentUser(response)
                if let delegate = self.delegate {
                    delegate.didLoginWithSuccess(self)
                }
            }
        })
    }
    
    // MARK: - Helper Methods
    
    func showLoginErrorAlert() {
        let alertController = UIAlertController(title: "Login Error", message: "You've entered the wrong credentials. If you haven't signed up, please sign up or login with Facebook.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func updateUserDefaultsToLoggedIn(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(userEmail!, forKey: "UserEmail")
        userDefaults.setObject(Constants.userLoggedInValueOK, forKey: Constants.userLoggedInKey)
        userDefaults.synchronize()
    }
    
    func updateCurrentUser(data: NSDictionary){
        currentUser = User.CurrentUser
        currentUser.email = userEmail!
        currentUser.fbId = FBSDKProfile.currentProfile().userID
        if let fName = data["first_name"] as? String {
            currentUser.first_name = fName
        }
        if let lName = data["last_name"] as? String {
            currentUser.last_name = lName
        }
        
        if let fullName = data["name"] as? String {
            currentUser.name = fullName
        }
    }
}