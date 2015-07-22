//
//  NewListingTableController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/21/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol NewListingTableDelegate {
    func textfieldDidEdit()
}

class NewListingTableController: UITableViewController {
    
    var delegate: NewListingTableDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldWillStartEditing(sender: UITextField) {
        sender.becomeFirstResponder()
    }
    
    @IBAction func textFieldFinishedEditing(sender: UITextField){
        sender.resignFirstResponder()
    }
    
    @IBAction func textFieldStartedEditing(sender: UITextField){
        if let delegate = self.delegate {
            delegate.textfieldDidEdit()
        }
    }
    
    // call when keyboard will be shown
    func keyboardWillBeShown(aNotification: NSNotification){
        let info: NSDictionary = aNotification.userInfo!
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue())!.size
        
        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    // call when keyboard's about to be hidden
    func keyboardWillBeHidden(aNotification: NSNotification){
        tableView.contentInset = UIEdgeInsetsZero
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
}
