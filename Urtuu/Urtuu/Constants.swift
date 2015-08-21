//
//  Constants.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

struct Constants {
    
    static var categories: [[String: AnyObject]]!
    static var properties: [String: [String: AnyObject]]!
    
    static let userLoggedInKey = "UserLoggedIn?"
    static let userLoggedInValueOK = "OK"
    static let UserLoggedOutNotification = "UserLoggedOut"
    
    static let OrderHistoryCellIdentifier = "OrderHistoryCell"
    
    init() {
        
        //getting categories
        let categoriesPath = NSBundle.mainBundle().pathForResource("Categories", ofType: "plist")!
        let categoriesInfo = NSDictionary(contentsOfFile: categoriesPath)!
        Constants.categories = categoriesInfo["categories"] as! [NSDictionary] as! [[String: AnyObject]]
        
        //getting properties
        let propertiesPath = NSBundle.mainBundle().pathForResource("Properties", ofType: "plist")!
        let propertiesInfo = NSDictionary(contentsOfFile: propertiesPath)!
        Constants.properties = propertiesInfo["properties"] as! NSDictionary as! [String :[String: AnyObject]]
    }
}