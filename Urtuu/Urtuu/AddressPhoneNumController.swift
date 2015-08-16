//
//  AddressPhoneNumController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/15/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class AddressPhoneNumController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        self.title = "Address and Phone"
        
        // adding save button to navigation bar
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "didPressSave")
        self.navigationItem.rightBarButtonItem = saveButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action Methods
    
    @IBAction func didTapTF(sender: UITextField){
        sender.becomeFirstResponder()
    }
    
    @IBAction func didFinishEditingTF(sender: UITextField){
        sender.resignFirstResponder()
    }
    
    // MARK: - Selectors
    
    func didPressSave(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
