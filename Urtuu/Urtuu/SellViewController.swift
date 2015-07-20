//
//  SellViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class SellViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listings: Listings!
    var listingCellIdentifier = "ListingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        listings = Listings.listings
        listings.myListings.append(Listing(identifier: 8))
        listings.myListings.append(Listing(identifier: 9))
        listings.myListings.append(Listing(identifier: 10))
        listings.myListings.append(Listing(identifier: 11))
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        height = collectionView.frame.height > 323.0 ? collectionView.frame.height / 2.5 : collectionView.frame.height / 2.0
        
        //println(collectionView.frame.height)
        
        return CGSizeMake(width, height)
    }
    
}
