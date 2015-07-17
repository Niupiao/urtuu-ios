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
    var title: String = "iPhone 6"
    var price: Double = 649.99
    var mainImage: UIImage = UIImage(named: "placeholder")!
    var categories: [String]! = []
    var rating: String = "Stellar"
    var images: NSMutableArray = [UIImage(named: "placeholder")!,UIImage(named: "iphone1")!,UIImage(named: "iphone2")!]
    var description: String = "the best phone money can buy"
    var seller: String = "Elon Musk"
    
    init(){
        
    }
    
    required init(identifier: Int){
        self.id = identifier
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