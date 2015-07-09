//
//  ItemCollectionViewCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/7/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    let liked = UIImage(named: "like-filled.png")
    let unliked = UIImage(named: "like.ong")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
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
                priceLabel.text = "$ " + String(format: "%.1f", newPrice)
            }
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
        let unliked = UIImage(named: "like.png")
        likeButton.setImage(itemLiked  ? liked : unliked, forState: .Normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
