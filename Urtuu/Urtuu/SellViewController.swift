//
//  SellViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class SellViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddListingViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noListingView: UIView!
    
    var listings: Listings!
    var listingCellIdentifier = "ListingCell"
    var collectionViewHidden = true
    
    let httpHelper = HTTPHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        listings = Listings.listings
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionViewHidden = listings.myListings.isEmpty
        collectionView.hidden = collectionViewHidden
        noListingView.hidden = !collectionViewHidden
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addListingPressed(sender: UIBarButtonItem) {
        let addListingNav = storyboard?.instantiateViewControllerWithIdentifier("NewListingNav") as! UINavigationController
        let addListingVC = addListingNav.viewControllers[0] as! AddListingTableViewController
        addListingVC.delegate = self
        println(addListingNav.viewControllers.count)
        
        presentViewController(addListingNav, animated: true, completion: nil)
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.myListings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(listingCellIdentifier, forIndexPath: indexPath) as! ListingCollectionViewCell
        
        cell.title = listings.myListings[indexPath.row].name
        cell.quantity = listings.myListings[indexPath.row].quantity
        cell.price = listings.myListings[indexPath.row].price
        cell.listingImage = listings.myListings[indexPath.row].mainImage
        
        return cell
    }
    
    // MARK: - Collection View Flow Layout Delegate Methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.15
        var height: CGFloat!
        height = collectionView.frame.height > 323.0 ? collectionView.frame.height / 2.6 : collectionView.frame.height / 2.0
        
        //println(collectionView.frame.height)
        
        return CGSizeMake(width, height)
    }
    
    // MARK: - Add Listing View Delegate Methods
    
    func didPressCancel(addView: AddListingTableViewController) {
        addView.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didPressAdd(addView: AddListingTableViewController, newListing listing: Listing) {
        listings.myListings.append(listing)
        let currentUser = User.CurrentUser
        let email = currentUser.email
        let fbId = currentUser.fbId
        addListingRequest(email!, fbId: fbId, newListing: listing)
        addView.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Urtu servers communication
    
    func addListingRequest(email: String, fbId: String, newListing: Listing){
        let httpRequest = httpHelper.buildSellRequest(email, fbId: fbId, itemName: newListing.name, price: newListing.price, quantity: newListing.quantity, description: newListing.description!, subcategory: newListing.itemSubcategory!, size: newListing.size, volume: newListing.volume, count: newListing.count)
        httpHelper.sendRequest(httpRequest, completion: {(data:NSData!, error:NSError!) in
            if error != nil {
                // error biatches
            }
            
            var error: NSError?
            let response = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &error) as! NSDictionary
            println()
        })
    }
}
