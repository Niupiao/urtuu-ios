//
//  AddListingViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol AddListingViewDelegate {
    func didPressCancel(addListing: AddListingViewController)
    func didPressAdd(addListing: AddListingViewController, newListing listing: Listing)
}

class AddListingViewController: UIViewController, NewListingTableDelegate {
    
    var delegate: AddListingViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addPressed:")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPressed:")
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem?.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelPressed(sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.didPressCancel(self)
        }
    }
    
    func addPressed(sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.didPressAdd(self, newListing: Listing())
        }
    }
    
    // MARK: - New Listing Table Delegate Methods
    
    func textfieldDidEdit(textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.enabled = !textField.text.isEmpty
    }
    
    // MARK: - Segues and whatnot
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embeddedTableView" {
            let tableVC = segue.destinationViewController as! NewListingTableController
            tableVC.delegate = self
        }
    }
}
