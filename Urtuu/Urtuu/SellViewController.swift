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
        let addListingVC = storyboard?.instantiateViewControllerWithIdentifier("AddListingViewController") as! AddListingViewController
        addListingVC.title = "Add New Listing"
        addListingVC.delegate = self
        let navController = UINavigationController(rootViewController: addListingVC)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.myListings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(listingCellIdentifier, forIndexPath: indexPath) as! ListingCollectionViewCell
        
        cell.title = listings.myListings[indexPath.row].title
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
    
    func didPressCancel(addListing: AddListingViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didPressAdd(addListing: AddListingViewController, newListing listing: Listing) {
        listings.myListings.append(listing)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
