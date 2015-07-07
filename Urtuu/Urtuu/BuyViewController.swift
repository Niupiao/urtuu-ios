//
//  BuyViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/6/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class BuyViewController: UITableViewController, UITableViewDataSource {
    
    var containerView: UIView!
    
    let navCellIdentifier = "navigationCell"
    let imageCellIdentifier = "imageCell"
    let images = [UIImage(named: "makeup.png"), UIImage(named: "baby.png"), UIImage(named: "recommend.png")]
    let subCats = ["makeup": ["Eyeliner","Foundation","Lipstick"],
        "baby": ["Baby Lotion","Clothes", "Socks","Diapers"],
        "recommended":[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier) as! ImageTableViewCell
        
        cell.imageFrame.image = images[section]
        cell.imageLabel.text = subCats.keys.array[section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0 * self.view.frame.height / 3.0
    }
    
    /*override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "makeup"
        case 1:
            return "baby"
        default:
            return "recommended"
        }
    }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return subCats["makeup"]!.count
        case 1:
            return subCats["baby"]!.count
        default:
            return 0
        }
    }
    
    // placeholder for now
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(navCellIdentifier, forIndexPath: indexPath) as! NavigationTableViewCell
        
        var key: String!
        switch(indexPath.section) {
        case 0:
            key = "makeup"
        case 1:
            key = "baby"
        default:
            key = "recommended"
        }
        
        cell.navigationLabel.text = subCats[key]![indexPath.row]
        
        return cell
    }
    
}
