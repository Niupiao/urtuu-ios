//
//  PropertyCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/11/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class PropertyCell: UITableViewCell {

    @IBOutlet weak var propertyLabel: UILabel!
    
    var propertyName: String? {
        get {
            if let name = propertyLabel.text {
                return name
            } else {
                return nil
            }
        }
        set(newName) {
            if newName != propertyName {
                propertyLabel.text = newName
            }
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
