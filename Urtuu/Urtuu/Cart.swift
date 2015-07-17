//
//  Cart.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/16/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

class Cart {
    
    class var cart: Cart {
        struct Singleton {
            static let instance = Cart()
        }
        return Singleton.instance
    }
    
    var items: Array<Item>!
    
    init() {
        items = []
    }
    
    func getTotal() -> Double {
        var total = 0.0
        for item in items {
            total += item.price
        }
        return total
    }
    
}