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
    
    var itemsList: ItemsList!
    var items: Array<Item>!
    var collectionViewHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsList = ItemsList.itemsList
        
        items = itemsList.itemsArray
        
        for i in 1...5 {
            let item = Item()
            item.price = Double(i)*29.49
            items.append(item)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.hidden = collectionViewHidden
        
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
        
        cell.title = item.title
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
        
        cell.title = item.title
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
            detailVC.title = items[indexPath.row].title
            detailVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        }
        if segue.identifier == "fromTableCell" {
            let cell = sender as! ItemTableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let detailVC = segue.destinationViewController as! ItemDetailViewController
            detailVC.itemSelected = items[indexPath.row]
            detailVC.title = items[indexPath.row].title
            detailVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        }
    }
}

