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
    var collapsedInfo : [Bool] = [false, false, false]
    var subCats: [[String]]? = nil
    var beautyCats: [String]? = nil
    var babyCats: [String]? = nil
    
    let categories = Constants.categories
    let navCellIdentifier = "navigationCell"
    let images = [UIImage(named: "makeup.png"), UIImage(named: "baby.png"), UIImage(named: "recommend.png")]
    
    let cats = ["Beauty Products","Baby Products","Recommended"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up subcats array
        beautyCats = []
        subCats = []
        babyCats = []
        for i in 0..<6 {
            beautyCats?.append(categories[i]["category"] as! String)
        }
        subCats?.append(beautyCats!)
        for i in 6...12 {
            babyCats?.append(categories[i]["category"] as! String)
        }
        subCats?.append(babyCats!)
        subCats?.append(["Test1","Test2","Test3"])
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
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 1.0 * self.view.frame.height / 3.0))
        
        let imageViewer = UIImageView(frame: CGRectMake(0, 0, tableView.frame.width, headerView.frame.height))
        imageViewer.image = images[section]
        headerView.addSubview(imageViewer)
        
        var headerLabel: UILabel = UILabel()
        
        let labelText = cats[section].capitalizedString as NSString
        let attributedString = NSMutableAttributedString(string: labelText as String)
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Zapfino", size: 30.0) ?? UIFont.systemFontOfSize(30.0)]
        attributedString.addAttributes(attributes, range: labelText.rangeOfString(labelText as String))
        headerLabel.attributedText = attributedString
        
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        headerView.addSubview(headerLabel)
        
        let xConstraint = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: headerView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let yConstraint = NSLayoutConstraint(item: headerLabel, attribute: .CenterY, relatedBy: .Equal, toItem: headerView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        headerView.addConstraint(xConstraint)
        headerView.addConstraint(yConstraint)
        
        headerView.tag = section
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "sectionHeaderTapped:"))
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 3.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return collapsedInfo[indexPath.section] ? 50 : 0
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer){
        
        //println("tap works")
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if indexPath.row == 0 {
            var collapsed = collapsedInfo[indexPath.section]
            collapsed = !collapsed;
            collapsedInfo[indexPath.section] = collapsed
            //reload specific section animated
            var range = NSMakeRange(indexPath.section, 1)
            var sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collapsedInfo[section] {
            return subCats![section].count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(navCellIdentifier, forIndexPath: indexPath) as! NavigationTableViewCell
        
        if(collapsedInfo[indexPath.section]){
            cell.navigationLabel.text = subCats![indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCart" {
            let cartVC = segue.destinationViewController as! CartViewController
            
            cartVC.title = "Cart"
        } else {
            let tableCell = sender as! NavigationTableViewCell
            let indexPath = tableView.indexPathForCell(tableCell)
            let title = tableCell.navigationLabel.text
            
            let catVC = segue.destinationViewController as! CategoryViewController
            catVC.title = title
        }
    }
}
