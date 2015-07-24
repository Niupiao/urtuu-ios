//
//  AddListingTableViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/23/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol AddListingViewDelegate {
    func didPressCancel()
}

class AddListingTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    var searchBar: UISearchBar!
    var delegate: AddListingViewDelegate?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // adding add and cancel buttons
        let addButton = UIBarButtonItem(title: "Add", style: .Plain, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: nil, action: "cancelPressed:")
        cancelButton.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = cancelButton
        addButton.enabled = false
        
    }
    
    func cancelPressed(sender: UIBarButtonItem){
        if let delegate = self.delegate {
            delegate.didPressCancel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up search bar
        let searchResultsController = NewListingSearchResultsController()
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.delegate = searchResultsController
        searchBar = searchController.searchBar
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
