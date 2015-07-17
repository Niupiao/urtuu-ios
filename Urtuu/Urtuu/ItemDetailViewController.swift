//
//  ItemDetailViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, CartViewDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var itemSelected: Item!
    var tableView = UITableView()
    var imageViewer: KASlideShow!
    var firstDetailView: UIView!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var sellerCell = UITableView()
    
    let detailCell = "ItemDetailCell"
    let sellerCellIdentifier = "SellerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = itemSelected.description.capitalizedString
        
        //creating scrollview
        scrollView = UIScrollView(frame: view.bounds)
        
        //creating contentView
        //let contentViewFrame = CGRectMake(0.0, 0.0, view.bounds.width, 200)
        contentView = UIView(frame: scrollView.bounds)
        
        //setting delegates and data sources
        scrollView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        sellerCell.dataSource = self
        sellerCell.delegate = self
        
        //registering cell class for tableView
        tableView.registerClass(ItemDetailCell.self, forCellReuseIdentifier: detailCell)
        let nib = UINib(nibName: "ItemDetailCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: detailCell)
        
        //registering cell class for sellerCell
        sellerCell.registerClass(SellerCell.self, forCellReuseIdentifier: sellerCellIdentifier)
        let sellerCellNib = UINib(nibName: "SellerCell", bundle: nil)
        sellerCell.registerNib(sellerCellNib, forCellReuseIdentifier: sellerCellIdentifier)
        
        //setting up imageViewer
        imageViewer = KASlideShow()
        imageViewer.setImagesDataSource(itemSelected.images)
        imageViewer.imagesContentMode = .ScaleAspectFill
        imageViewer.transitionDuration = 0.7
        imageViewer.delay = 3.0
        imageViewer.transitionType = KASlideShowTransitionType.Slide
        imageViewer.addGesture(KASlideShowGestureType.Swipe)
        
        //setting up firstdetailview
        firstDetailView = UIView()
        firstDetailView.layer.borderColor = UIColor.grayColor().CGColor
        firstDetailView.layer.borderWidth = 0.5
        firstDetailView.backgroundColor = UIColor.whiteColor()
        
        // adding itemlabel to firstdetailview
        var itemLabel = UILabel()
        itemLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        itemLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0) ?? UIFont()
        itemLabel.text = itemSelected.title
        firstDetailView.addSubview(itemLabel)
        
        //adding pricelabel to firstdetailview
        var priceLabel = UILabel()
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont(name: "Helvetica-Bold", size: 14.0) ?? UIFont()
        priceLabel.text = "$" + String(format:"%.2f", itemSelected.price)
        priceLabel.textAlignment = .Right
        firstDetailView.addSubview(priceLabel)
        
        //disabling autoresizing for tableview, firstdetailview, and imageviewer
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        firstDetailView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageViewer.setTranslatesAutoresizingMaskIntoConstraints(false)
        sellerCell.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //adding horizontal constraints to itemLabel and pricelabel
        let views = Dictionary(dictionaryLiteral: ("itemLabel",itemLabel),("priceLabel",priceLabel))
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[itemLabel]-[priceLabel]-|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(hConstraint)
        
        //adding vertical constrains to itemlabel and pricelabel
        let itemVContraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[itemLabel]|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(itemVContraints)
        let priceVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[priceLabel]|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(priceVConstraints)
        
        //adding subviews to scrollView
        contentView.addSubview(imageViewer)
        contentView.addSubview(firstDetailView)
        contentView.addSubview(tableView)
        contentView.addSubview(sellerCell)
        
        //master views dictionary
        let masterViews = Dictionary(dictionaryLiteral: ("tableView",tableView),("firstDetailView",firstDetailView),("imageViewer",imageViewer),("contentView",contentView),("sellerCell",sellerCell))
        
        //setting up horizontal and vertical constrains for imageviewer, firstdetailview, and tableView
        let hTblConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[tableView(<=contentView)]-4-|", options: nil, metrics: nil, views: masterViews)
        let hImgConstrains = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageViewer(==contentView)]|", options: nil, metrics: nil, views: masterViews)
        let hSlrCellConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[sellerCell(==contentView)]|", options: nil, metrics: nil, views: masterViews)
        let hFrstDtlConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(-1)-[firstDetailView(>=contentView)]-(-1)-|", options: nil, metrics: nil, views: masterViews)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageViewer(==300)]-0-[firstDetailView(==50)]-0-[sellerCell(==92)]-4-[tableView(==175)]", options: nil, metrics: nil, views: masterViews)
        
        //adding constraints to scrollView
        contentView.addConstraints(hTblConstraints)
        contentView.addConstraints(hSlrCellConstraints)
        contentView.addConstraints(hImgConstrains)
        contentView.addConstraints(hFrstDtlConstraints)
        contentView.addConstraints(vConstraints)
        
        scrollView.addSubview(contentView)
        
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        let height = tableView.frame.height + imageViewer.frame.height + firstDetailView.frame.height + sellerCell.frame.height
        scrollView.contentSize = CGSizeMake(contentView.frame.width, height)        
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let scvHConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        let scvVConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-toolbarHeight-[scrollView]|", options: nil, metrics: ["toolbarHeight":44], views: ["scrollView":scrollView,"topToolbar":topToolbar,"bottomToolbar":bottomToolbar])
        
        view.addConstraints(scvHConstraint)
        view.addConstraints(scvVConstraint)
        
        imageViewer.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: UIBarButtonItemStyle.Plain, target: self, action: "cartPressed")
    }
    
    func cartPressed() {
        let cartVC = storyboard?.instantiateViewControllerWithIdentifier("cartViewController") as! CartViewController
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.hidden = false
        
        imageViewer.stop()
    }
    
    @IBAction func buyPressed(sender: UIBarButtonItem) {
        var cart = Cart.cart
        cart.items.append(itemSelected)
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView == self.tableView ? CGFloat(35) : CGFloat(92)
    }
    
    // MARK: - Table View Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? 5 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = self.tableView.dequeueReusableCellWithIdentifier(detailCell) as! ItemDetailCell
            
            switch(indexPath.row) {
            case 0:
                cell.detailTitle = "Category:"
                cell.detail = "Smartphone"
            case 1:
                cell.detailTitle = "Brand:"
                cell.detail = "Apple"
            case 2:
                cell.detailTitle = "Payment:"
                cell.detail = "Credit, Debit, Cash"
            case 3:
                cell.detailTitle = "Ships From:"
                cell.detail = "Ulaanbataar"
            default:
                cell.detailTitle = "Ships Within:"
                cell.detail = "1-2 Hours"
            }
            
            return cell
        } else {
            let cell = sellerCell.dequeueReusableCellWithIdentifier(sellerCellIdentifier) as! SellerCell
            
            cell.sellerName = itemSelected.seller
            cell.profilePic = UIImage(named: "elon")!
            cell.numberOfReviews.text = "77 reviews"
            
            return cell
        }
    }
    
    // MARK: - Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cartVC = segue.destinationViewController as! CartViewController
        
        cartVC.itemBought = itemSelected
        cartVC.delegate = self
    }
    
    // MARK: - Cart View Delegate Methods
    
    func dismissCartView(cartView: CartViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let navControllers = self.navigationController?.viewControllers as! [UIViewController]
        self.navigationController?.popToViewController(navControllers[1], animated: true)
    }
}
