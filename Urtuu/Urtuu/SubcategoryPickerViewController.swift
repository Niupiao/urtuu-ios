//
//  SubcategoryPickerViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol SubcategoryPickerDelegate {
    func didPickSubcategory(newSubcategory subCat: String)
}

class SubcategoryPickerViewController: UITableViewController {
    
    var subcategories: [String]? = nil
    var delegate: SubcategoryPickerDelegate?
    
    let subcategoryCellIdentifier = "SubcategoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subcategories = self.subcategories {
            return subcategories.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(subcategoryCellIdentifier) as! SubcategoryCell
        
        if let subcategories = self.subcategories {
            cell.subcategoryName = subcategories[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let categoryCell = tableView.cellForRowAtIndexPath(indexPath) as! SubcategoryCell
        if let delegate = self.delegate {
            delegate.didPickSubcategory(newSubcategory: categoryCell.subcategoryName!)
        }
    }
}
