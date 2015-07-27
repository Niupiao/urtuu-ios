//
//  NewListingSearchResultsController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/23/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class NewListingSearchResultsController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, Sem3ObjCDelegate {
    
    let api_key = "SEM3B141C9316943EE3739AE691468ABBF07"
    let api_secret = "ZDdmOTUxOTUzZGY4NTBkZTllZWFkYTg0M2RjMmUzODk"
    
    var searchResults: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        searchResults = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.textLabel?.text = "Hello, Search!"
        
        return cell
    }
    
    // MARK: - Search Controller Delegate Methods
    
    func didPresentSearchController(searchController: UISearchController) {
        let sbHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        var contentInset = tableView.contentInset
        contentInset.top = 44
        
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
        
        var origin = tableView.frame.origin
        origin.y = sbHeight
        tableView.frame.origin = origin
    }
    
    // MARK: - Search Bar Delegate Methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let itemName = searchBar.text
        
        println(itemName)
        
        // initiating semantics3 request for product
        let sem3 = semantics3_objc(semantic3Request: api_key, withapiSecret: api_secret, andEndpoints: "products")
        
        sem3.delegate = self
        
        var tempDict = NSMutableDictionary()
        tempDict.setValue("iphone", forKey: "search")
        sem3.field(tempDict)
        sem3.runQuery()
    }
    
    // MARK: - Sem3 ObjC Delegate Methods
    
    func queryData(content: String!) {
        println(content)
    }
}
