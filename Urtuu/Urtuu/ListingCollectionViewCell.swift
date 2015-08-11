//
//  ListingCollectionViewCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var listingImage: UIImage {
        get {
            return listingImageView.image!
        }
        set(newImage){
            listingImageView.image = newImage
        }
    }
    
    var price: Double {
        get {
            return 0.0
        }
        set(newPrice){
            priceLabel.text = "$" + String(format: "%.2f", newPrice)
        }
    }
    
    var title: String {
        get {
            return titleLabel.text!
        }
        set(newTitle){
            titleLabel.text = newTitle
        }
    }
    
    var quantity: Int {
        get {
            return 0
        }
        set(newQuantity) {
            quantityLabel.text = String(newQuantity)
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
