//
//  User.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

class User {
    var photo: UIImage = UIImage(named: "elon")!
    var paymentMethod: String = "Cash"
    var address: String = "77, Main Street, Ulaanbataar"
    var deliveryInstructions: String = "Call when here"
    var phoneNumber = "(224) 610-1626"
    var name: String = "Elon Musk"
    var rating: String = "Stellar"
    
    init(){
        
    }
    
    required init(name: String){
        self.name = name
    }
}

class UsersList {
    class var usersList: UsersList {
        struct Singleton {
            static let instance = UsersList()
        }
        return Singleton.instance
    }
    
    var currentUser: User!
    var users: Array<User>!
    
    required init(){
        users = []
        currentUser = User()
    }
}
