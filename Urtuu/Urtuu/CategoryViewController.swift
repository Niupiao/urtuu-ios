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
    @IBOutlet weak var listButton: UIBarButtonItem!
    @IBOutlet weak var collectionViewButton: UIBarButtonItem!
    
    let itemCellIdentifier = "itemCollectionViewCell"
    
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
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sortButtonPressed(sender: UIBarButtonItem) {
        let sortController = UIAlertController(title: "Sort", message: nil, preferredStyle: .ActionSheet)
        
        let sortByPriceAscn = UIAlertAction(title: "Price: Low to High", style: .Default, handler: { action in
            self.items.sort() { $0.price < $1.price }
            self.collectionView.reloadData()
        })
        
        let sortByPriceDesc = UIAlertAction(title: "Price: High to Low", style: .Default, handler: {action in
            self.items.sort() { $0.price > $1.price }
            self.collectionView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        sortController.addAction(sortByPriceAscn)
        sortController.addAction(sortByPriceDesc)
        sortController.addAction(cancel)
        presentViewController(sortController, animated: true, completion: nil)
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(itemCellIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        
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
}
