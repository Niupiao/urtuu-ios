//
//  ItemDetailViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var itemSelected: Item!
    var tableView = UITableView()
    var imageViewer: UIImageView!
    var firstDetailView: UIView!
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    let detailCell = "ItemDetailCell"
    
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
        
        //registering cell class
        tableView.registerClass(ItemDetailCell.self, forCellReuseIdentifier: detailCell)
        let nib = UINib(nibName: "ItemDetailCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: detailCell)
        
        //setting up imageViewer
        imageViewer = UIImageView()
        imageViewer.image = itemSelected.images[1]
        imageViewer.contentMode = .ScaleAspectFill
        imageViewer.clipsToBounds = true
        
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
        
        //master views dictionary
        let masterViews = Dictionary(dictionaryLiteral: ("tableView",tableView),("firstDetailView",firstDetailView),("imageViewer",imageViewer),("contentView",contentView))
        
        //setting up horizontal and vertical constrains for imageviewer, firstdetailview, and tableView
        let hTblConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[tableView(<=contentView)]-4-|", options: nil, metrics: nil, views: masterViews)
        let hImgConstrains = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageViewer(==contentView)]|", options: nil, metrics: nil, views: masterViews)
        let hFrstDtlConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[firstDetailView(==contentView)]|", options: nil, metrics: nil, views: masterViews)
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageViewer(==300)]-0-[firstDetailView(==50)]-4-[tableView(==140)]", options: nil, metrics: nil, views: masterViews)
        
        //adding constraints to scrollView
        contentView.addConstraints(hTblConstraints)
        contentView.addConstraints(hImgConstrains)
        contentView.addConstraints(hFrstDtlConstraints)
        contentView.addConstraints(vConstraints)
        
        scrollView.addSubview(contentView)
        
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        let height = tableView.frame.height + imageViewer.frame.height + firstDetailView.frame.height
        scrollView.contentSize = CGSizeMake(contentView.frame.width, height)
        
        println(scrollView.contentSize.height)
        println(contentView.frame.height)
        
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let scvHConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        let scvVConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-toolbarHeight-[scrollView]|", options: nil, metrics: ["toolbarHeight":44], views: ["scrollView":scrollView,"topToolbar":topToolbar,"bottomToolbar":bottomToolbar])
        
        view.addConstraints(scvHConstraint)
        view.addConstraints(scvVConstraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(35)
    }
    
    // MARK: - Table View Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(detailCell) as! ItemDetailCell
        
        cell.detailTitle = "Detail:"
        cell.detail = "Some detail."
        
        return cell
    }
    
}
