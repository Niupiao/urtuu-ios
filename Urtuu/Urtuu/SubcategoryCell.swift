//
//  SubcategoryCell.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 8/10/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell {

    @IBOutlet weak var subcategoryLabel: UILabel!
    
    var subcategoryName: String? {
        get {
            if let name = subcategoryLabel.text {
                return name
            } else {
                return nil
            }
        }
        set(newName){
            if newName != subcategoryName {
                subcategoryLabel.text = newName
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
