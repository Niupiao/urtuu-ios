//
//  Listing.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

class Listing: Item {
    var active: Bool = true
    
    override init(){
        super.init()
    }
    
    required init(identifier: Int) {
        super.init(identifier: identifier)
    }
}

class Listings {
    class var listings: Listings {
        struct Singleton {
            static let instance = Listings()
        }
        return Singleton.instance
    }
    
    var myListings: Array<Listing>!
    
    init() {
        myListings = []
    }
    
}