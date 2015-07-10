//
//  ItemTableViewCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/9/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    let liked = UIImage(named: "like-filled.png")
    let unliked = UIImage(named: "like.ong")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    
    var itemLiked: Bool = false
    
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
                priceLabel.text = "$ " + String(format: "%.2f", newPrice)
            }
        }
    }
    
    var rating: String! {
        get {
            return ratingLabel.text
        }
        set(newRating) {
            if newRating != rating {
                ratingLabel.text = newRating
            }
        }
    }
    
    var itemPic: UIImage! {
        get {
            return itemImage.image!
        }
        set(newImage){
            itemImage.image = newImage
        }
    }
    
    @IBAction func likePressed(sender: UIButton) {
        if(!itemLiked){
            likeButton.setImage(liked, forState: .Normal)
        } else {
            likeButton.setImage(unliked, forState: .Normal)
        }
        itemLiked = !itemLiked
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeButton.setImage(itemLiked  ? liked : unliked, forState: .Normal)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
