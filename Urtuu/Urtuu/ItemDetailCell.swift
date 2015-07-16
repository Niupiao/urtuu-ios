//
//  ItemDetailCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/13/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class ItemDetailCell: UITableViewCell {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var detailTitle: String {
        get {
            return detailTitleLabel.text!
        }
        set(newTitle){
            detailTitleLabel.text = newTitle
        }
    }
    
    var detail: String {
        get {
            return detailLabel.text!
        }
        set(newDetail) {
            detailLabel.text = newDetail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
