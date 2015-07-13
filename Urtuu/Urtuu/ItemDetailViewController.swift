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
    @IBOutlet weak var scrollView: UIScrollView!
    
    var itemSelected: Item!
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = itemSelected.description.capitalizedString
        
        scrollView.delegate = self
        tableView.dataSource = self
        
        var imageViewer = UIImageView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height / 2.0))
        imageViewer.image = itemSelected.images[1]
        imageViewer.contentMode = .ScaleAspectFill
        
        var firstDetailView = UIView(frame: CGRectMake(0.0, imageViewer.frame.height, view.frame.width, 50))
        firstDetailView.layer.borderColor = UIColor.grayColor().CGColor
        firstDetailView.layer.borderWidth = 0.5
        
        var itemLabel = UILabel()
        itemLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        itemLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0) ?? UIFont()
        itemLabel.text = itemSelected.title
        firstDetailView.addSubview(itemLabel)
        
        var priceLabel = UILabel()
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont(name: "Helvetica", size: 14.0) ?? UIFont()
        priceLabel.text = "$" + String(format:"%.2f", itemSelected.price)
        priceLabel.textAlignment = .Right
        firstDetailView.addSubview(priceLabel)
        
        //adding constraints to itemLabel
        let views = Dictionary(dictionaryLiteral: ("itemLabel",itemLabel),("priceLabel",priceLabel))
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[itemLabel]-[priceLabel]-8-|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(hConstraint)
        
        let itemVContraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[itemLabel]|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(itemVContraints)
        
        let priceVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[priceLabel]|", options: nil, metrics: nil, views: views)
        firstDetailView.addConstraints(priceVConstraints)
        
        //tableView.frame.origin = CGPoint(x: 0.0, y: imageViewer.frame.height)
        
        scrollView.addSubview(imageViewer)
        scrollView.addSubview(firstDetailView)
        //scrollView.addSubview(tableView)
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
    
    // MARK: - Table View Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
