//
//  PaymentSettingsController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/15/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class PaymentSettingsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        self.title = "Payment Info"
        
        // adding save button to navigation bar
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "didPressSave")
        self.navigationItem.rightBarButtonItem = saveButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
