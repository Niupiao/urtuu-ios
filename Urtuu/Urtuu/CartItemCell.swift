//
//  CartItemCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/16/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSellerLabel: UILabel!
    
    var itemImage: UIImage {
        get {
            return itemImageView.image!
        }
        set(newImage) {
            itemImageView.image = newImage
        }
    }
    
    var itemTitle: String {
        get {
            return itemTitleLabel.text!
        }
        set(newTitle){
            itemTitleLabel.text = newTitle
        }
    }
    
    var itemSeller: String {
        get {
            return itemSellerLabel.text!
        }
        set(newSeller){
            itemSellerLabel.text = newSeller
        }
    }
    
    var itemPrice: Double! {
        get {
            return 0.0
        }
        set(newPrice){
            priceLabel.text = "$" + String(format: "%.2f", newPrice)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemPrice = 0
        
        itemImageView.contentMode = .ScaleAspectFill
        itemImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
