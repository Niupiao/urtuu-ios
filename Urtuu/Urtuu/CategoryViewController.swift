//
//  CategoryViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/7/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemCellIdentifier = "itemCollectionViewCell"
    var items = [ ["title":"iPhone", "price": "840", "rating":"Great phone"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        items.append(["title":"iPhone", "price": "740", "rating":"Great phone"])
        items.append(["title":"iPhone", "price": "640", "rating":"Great phone"])
        items.append(["title":"iPhone", "price": "540", "rating":"Great phone"])
        items.append(["title":"iPhone", "price": "440", "rating":"Great phone"])
        items.append(["title":"iPhone", "price": "340", "rating":"Great phone"])
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(itemCellIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        
        cell.title = items[indexPath.row]["title"]
        cell.price = (items[indexPath.row]["price"]! as NSString).doubleValue
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "imageDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        cell.addGestureRecognizer(doubleTapRecognizer)
        
        return cell
    }
    
    func imageDoubleTapped(recognizer: UITapGestureRecognizer){
        //println("double tapping works")
        let cell = recognizer.view as! ItemCollectionViewCell
        cell.likeButton.setImage(cell.liked, forState: .Normal)
        cell.itemLiked = true
    }
    
    // MARK: - Collection View Delegate Flow Layout Methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.1
        var height: CGFloat!
        height = collectionView.frame.height > 323.0 ? collectionView.frame.height / 2.1 : collectionView.frame.height / 1.5
        
        //println(collectionView.frame.height)
        
        return CGSizeMake(width, height)
    }
}
