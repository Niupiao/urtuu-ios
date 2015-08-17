//
//  OrderHistoryViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/15/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    let httpHelper = HTTPHelper()
    var currentUser: User!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyHistoryView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        self.title = "Order History"
        
        // current user
        currentUser = User.CurrentUser
        
        // request order history from server
        if currentUser.orderHistory == nil {
            if let email = currentUser.email {
                let fbId = currentUser.fbId
                activityIndicator.startAnimating()
                requestOrderHistory(email, fbId: fbId)
            } else {
                println("Email is nil")
            }
        } else {
            if currentUser.orderHistory!.count == 0 {
                emptyHistoryView.hidden = false
                activityIndicator.hidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Urtuu Server Methods
    
    func requestOrderHistory(email: String, fbId: String){
        let httpRequest = httpHelper.buildOrderHistoryRequest(email, fbId: fbId)
        httpHelper.sendRequest(httpRequest, completion: { (data: NSData!, error: NSError!) in
            
            if error != nil {
                // well, shit again
            }
        
            var error: NSError?
            let responseDict = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error) as! NSDictionary
            self.currentUser.orderHistory = responseDict["mobile"] as? NSArray
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            if self.currentUser.orderHistory!.count == 0 {
                self.emptyHistoryView.hidden = false
            } else {
                // show items
            }
        })
    }
}
