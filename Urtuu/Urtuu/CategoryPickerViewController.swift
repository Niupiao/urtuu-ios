//
//  CategoryPickerViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class CategoryPickerViewController: UITableViewController {
    
    weak var addListingController: AddListingTableViewController? = nil
    weak var newListing: Listing? = nil
    var categories: [[String: AnyObject]]!

    let categoryCellIdentifier = "CategoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pick A Category"
        
        categories = Constants.categories
    }
    
    // MARK: - Table View Data Source Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(categoryCellIdentifier) as! CategoryCell
        cell.categoryName = categories[indexPath.row]["category"] as? String
        
        return cell
    }
    
    // MARK: - Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickSubcategory" {
            let pickSubcatVC = segue.destinationViewController as! SubcategoryPickerViewController
            let senderCell = sender as! CategoryCell
            let indexPath = tableView.indexPathForCell(senderCell)!
            
            if let newListing = self.newListing {
                newListing.itemCategory = senderCell.categoryName!
            }
            
            if let addListingVC = addListingController {
                pickSubcatVC.delegate = addListingVC
            }
            
            pickSubcatVC.subcategories = categories[indexPath.row]["subcategories"] as? [String]
        }
    }
}
