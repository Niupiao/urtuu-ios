//
//  BasicInfoController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/15/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class BasicInfoController: UITableViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var middleNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Basic Information"
        
        // current user
        currentUser = User.CurrentUser
        
        // setting up text fields
        if let firstName = currentUser.first_name {
            firstNameTF.text = firstName
        }
        if let middleName = currentUser.middle_name {
            middleNameTF.text = middleName
        }
        if let lastName = currentUser.last_name {
            lastNameTF.text = lastName
        }
        
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
