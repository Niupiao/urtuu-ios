//
//  CategoryViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/7/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listButton: UIBarButtonItem!
    @IBOutlet weak var collectionViewButton: UIBarButtonItem!
    @IBOutlet weak var gridButton: UIBarButtonItem!
    
    
    let itemCollectionCellIdentifier = "itemCollectionCell"
    let itemTableCellIdentifier = "itemTableCell"
    let httpHelper = HTTPHelper()
    
    var currentUser: User!
    var itemsList: ItemsList!
    var items: Array<Item>!
    var collectionViewHidden: Bool = false
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsList = ItemsList.itemsList
        items = itemsList.itemsArray
        
        currentUser = User.CurrentUser
        
        if let email = currentUser.email {
            let fbId = currentUser.fbId
            requestItems(email, fbId: fbId, pageSize: "10", page: "1")
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.hidden = collectionViewHidden
        // how to add search bar to top of collection view?
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hidden = !collectionViewHidden
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: UIBarButtonItemStyle.Plain, target: self, action: "cartPressed")
    }
    
    func cartPressed() {
        let cartVC = storyboard?.instantiateViewControllerWithIdentifier("cartViewController") as! CartViewController
        cartVC.title = "Cart"
        
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func sortButtonPressed(sender: UIBarButtonItem) {
        let sortController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let sortByPriceAscn = UIAlertAction(title: "Price: Low to High", style: .Default, handler: { action in
            self.items.sort() { $0.price < $1.price }
            if self.collectionViewHidden {
                self.tableView.reloadData()
            } else {
                self.collectionView.reloadData()
            }
        })
        
        let sortByPriceDesc = UIAlertAction(title: "Price: High to Low", style: .Default, handler: {action in
            self.items.sort() { $0.price > $1.price }
            if self.collectionViewHidden {
                self.tableView.reloadData()
            } else {
                self.collectionView.reloadData()
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        sortController.addAction(sortByPriceAscn)
        sortController.addAction(sortByPriceDesc)
        sortController.addAction(cancel)
        presentViewController(sortController, animated: true, completion: nil)
    }
    
    
    @IBAction func listViewPressed(sender: UIBarButtonItem) {
        if !collectionViewHidden {
            collectionViewHidden = !collectionViewHidden
            collectionView.hidden = collectionViewHidden
            tableView.hidden = !collectionViewHidden
            tableView.reloadData()
        }
    }
    
    @IBAction func gridViewPressed(sender: UIBarButtonItem) {
        if collectionViewHidden {
            collectionViewHidden = !collectionViewHidden
            collectionView.hidden = collectionViewHidden
            tableView.hidden = !collectionViewHidden
            collectionView.reloadData()
        }
    }
    
    // MARK: - Collection View Data Source Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return collectionViewHidden ? 0 : 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(itemCollectionCellIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        
        let item = items[indexPath.row]
        
        cell.title = item.name
        cell.price = item.price
        cell.rating = item.rating
        
        return cell
    }
    
    // MARK: - Collection View Delegate Flow Layout Methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.1
        var height: CGFloat!
        height = collectionView.frame.height > 323.0 ? collectionView.frame.height / 2.1 : collectionView.frame.height / 1.5
        
        //println(collectionView.frame.height)
        
        return CGSizeMake(width, height)
    }
    
    // MARK: - Table View Data Source Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collectionViewHidden ? 1 : 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(itemTableCellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        
        let item = items[indexPath.row]
        
        cell.title = item.name
        cell.price = item.price
        cell.rating = item.rating
        cell.itemPic = item.mainImage
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 1.1
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fromCollectionCell" {
            let cell = sender as! ItemCollectionViewCell
            let indexPath = collectionView.indexPathForCell(cell)!
            
            let detailVC = segue.destinationViewController as! ItemDetailViewController
            detailVC.itemSelected = items[indexPath.row]
            detailVC.title = items[indexPath.row].name
        }
        if segue.identifier == "fromTableCell" {
            let cell = sender as! ItemTableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let detailVC = segue.destinationViewController as! ItemDetailViewController
            detailVC.itemSelected = items[indexPath.row]
            detailVC.title = items[indexPath.row].name
        }
    }
    
    // MARK: - Urtu Servers Communication
    // This should be moved to BuyViewController. If you can't get items per category, then it may be better to get all items in BuyViewController
    // and then go through and sort per category.
    
    func requestItems(email: String, fbId: String, pageSize: String, page: String) {
        let httpRequest = httpHelper.buildItemsRequest(email, fbId: fbId, pageSize: pageSize, pageNumber: page)
        httpHelper.sendRequest(httpRequest, completion: { (data: NSData!, error: NSError!) in
            if error != nil {
                // error, shits
            }
            
            var error: NSError?
            let response = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error) as! NSArray
            self.itemsList.itemsArray = self.httpHelper.parseItemsJsonArray(response, category: self.category)
            self.items = self.itemsList.itemsArray
            self.collectionView.reloadData()
        })
    }
}

