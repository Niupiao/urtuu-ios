//
//  AccountViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/12/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // setting up currentUser
        currentUser = User.CurrentUser
        
        // setting up welcome label
        var welcomeLabelString = welcomeLabel.text! as NSString
        if welcomeLabelString.length > 13 {
            println("Name here")
        } else {
            if let fName = currentUser.first_name {
                let welcomeString = "Welcome back, \(fName)."
                let welcomeAttributedString = NSMutableAttributedString(string: welcomeString)
                let nameRange = (welcomeString as NSString).rangeOfString(fName + ".")
                welcomeAttributedString.setAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(welcomeLabel.font.pointSize)], range: nameRange)
                welcomeLabel.attributedText = welcomeAttributedString
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods

    @IBAction func didPressLogout(sender: UIBarButtonItem) {
        
        let actionController = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .ActionSheet)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .Destructive, handler: {action in
            let loginManager = FBSDKLoginManager()
            if FBSDKAccessToken.currentAccessToken() != nil {
                loginManager.logOut()
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(nil, forKey: Constants.userLoggedInKey)
                userDefaults.synchronize()
                self.currentUser.clearCurrentUser()
                NSNotificationCenter.defaultCenter().postNotificationName(Constants.UserLoggedOutNotification, object: self)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionController.addAction(logoutAction)
        actionController.addAction(cancelAction)
        presentViewController(actionController, animated: true, completion: nil)
    }
}
