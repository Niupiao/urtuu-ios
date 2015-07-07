//
//  ImageTableViewCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/6/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    

    @IBOutlet weak var imageFrame: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
