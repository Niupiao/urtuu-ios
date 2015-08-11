//
//  PropertyPickerController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/11/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol PropertyPickerDelegate {
    func didPickProperty(propertyPicker: PropertyPickerController, propertyType: String, property prop: String)
}

class PropertyPickerController: UITableViewController {
    
    var propertyOptions: [String]? = nil
    var propertyType: String? = nil
    var delegate: PropertyPickerDelegate?
    
    let propertyCellIdentifier = "PropertyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Data Source Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let propertyOptions = self.propertyOptions {
            return propertyOptions.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(propertyCellIdentifier) as! PropertyCell
        
        if let propertyOptions = self.propertyOptions {
            cell.propertyName = propertyOptions[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = self.delegate {
            if let type = propertyType {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! PropertyCell
                delegate.didPickProperty(self, propertyType: type, property: cell.propertyName!)
            }
        }
    }
}
