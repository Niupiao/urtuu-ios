//
//  CartViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/16/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

protocol CartViewDelegate {
    func dismissCartView(cartView: CartViewController)
}

class CartViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var shopToolbarButton: UIBarButtonItem!
    
    var cart: Cart!
    var itemBought: Item?
    var delegate: CartViewDelegate?
    
    let cartItemCellIdentifier = "CartItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        cart = Cart.cart
        
        //setting up topToolbar
        var items: [AnyObject] = topToolbar.items!
 
        let rSpacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        items.append(rSpacer)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        titleLabel.text = "Cart"
        titleLabel.textAlignment = .Center
        titleLabel.frame.size = CGSizeMake(50.0, topToolbar.frame.height)
        
        let title = UIBarButtonItem(customView: titleLabel)
        items.append(title)
        
        let lSpacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        items.append(lSpacer)
        
        topToolbar.setItems(items, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if itemBought != nil {
            cart.items.append(itemBought!)
        }
        
        totalView.layer.borderColor = UIColor.grayColor().CGColor
        totalView.layer.borderWidth = 0.5
        
        totalLabel.text = "$" + String(format: "%.2f", cart.getTotal())
        
        if let navBar = self.navigationController?.navigationBar {
            topToolbar.hidden = true
            self.tabBarController?.tabBar.hidden = true
            
            //hide shop button
            
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.dismissCartView(self)
        }
    }
    
    // MARK: - Table View Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cartItemCellIdentifier) as! CartItemCell
        
        cell.itemPrice = cart.items[indexPath.row].price
        cell.itemSeller = cart.items[indexPath.row].seller
        cell.itemImage = cart.items[indexPath.row].mainImage
        cell.itemTitle = cart.items[indexPath.row].title
        
        return cell
    }
    
}
