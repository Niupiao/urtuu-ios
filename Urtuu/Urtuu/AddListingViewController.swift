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

class AddListingViewController: UIViewController {
    
    var delegate: AddListingViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.didPressCancel(self)
        }
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.didPressAdd(self, newListing: Listing())
        }
    }
}
