//
//  ItemDetailViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var itemSelected: Item!
    var pageViews: [UIImageView?] = []
    var pageCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageCount = itemSelected.images.count
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        scrollView.frame.size = CGSizeMake(view.frame.width, view.frame.height/2.0)
        let pageSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pageSize.width * CGFloat(pageCount), pageSize.height)
        loadVisiblePages()
        scrollView.delegate = self
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
    

    // MARK: - Helper Functions
    
    func loadPage(page: Int){
        if page < 0 || page >= pageCount {
            // page outside of range, do nothing
            return
        }
        
        if let pageView = pageViews[page] {
            // page already loaded, do nothing
            return
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: itemSelected.images[page])
            newPageView.contentMode = .ScaleToFill
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
        
        
    }
    
    func purgePage(page: Int){
        if page < 0 || page >= pageCount {
            // page outside of range, do nothing
            return
        }
        
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages(){
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor(scrollView.contentOffset.x * 2.0 + pageWidth)/(2.0 * pageWidth))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        for var index = 0; index < firstPage; index++ {
            purgePage(index)
        }
        
        for index in firstPage ... lastPage {
            loadPage(index)
        }
        
        for var index = lastPage + 1; index < itemSelected.images.count; index++ {
            purgePage(index)
        }
    }
    
    // MARK: - Scroll View Delegate Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
}
