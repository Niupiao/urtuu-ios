//
//  Item.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/9/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var id: Int = 0
    var title: String = "iPhone"
    var price: Double = 649.99
    var image: UIImage = UIImage(named: "placeholder.png")!
    var categories: [String]! = []
    var rating: String = "Stellar"
    
    init(){
        
    }
}

class ItemsList {
    
    class var itemsList: ItemsList {
        struct Singleton {
            static let instance = ItemsList()
        }
        return Singleton.instance
    }
    
    var itemsArray: Array<Item>!
    
    init() {
        itemsArray = []
    }
}