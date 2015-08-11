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
    
    init() {
        let path = NSBundle.mainBundle().pathForResource("Categories", ofType: "plist")!
        let categoriesInfo = NSDictionary(contentsOfFile: path)!
        Constants.categories = categoriesInfo["categories"] as! [NSDictionary] as! [[String: AnyObject]]
    }
}