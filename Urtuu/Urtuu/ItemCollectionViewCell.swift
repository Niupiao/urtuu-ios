//
//  ItemCollectionViewCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/7/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var title: String! {
        get{
            return titleLabel.text
        }
        set(newTitle) {
            if newTitle != title {
                titleLabel.text = newTitle
            }
        }
    }
    
    var price: Double! {
        get {
            return (priceLabel.text! as NSString).doubleValue
        }
        
        set(newPrice) {
            if newPrice != price {
                priceLabel.text = "$ " + String(format: "%.1f", newPrice)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
