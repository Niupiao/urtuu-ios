//
//  SellerCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/15/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class SellerCell: UITableViewCell {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var numberOfReviews: UILabel!
    
    var profilePic: UIImage {
        get {
            return profilePictureView.image!
        }
        set(newImage) {
            profilePictureView.image = newImage
        }
    }
    
    var sellerName: String {
        get {
            return profileName.text!
        }
        set(newName) {
            profileName.text = newName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePictureView.contentMode = .ScaleAspectFill
        profilePictureView.clipsToBounds = true
        profilePictureView.layer.cornerRadius = profilePictureView.frame.height / 2.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
