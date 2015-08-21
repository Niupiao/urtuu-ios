//
//  User.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

enum PaymentSettings {
    case Cash, Debit, BankAccount
}

class User {
    
    class var CurrentUser: User {
        struct Singleton {
            static let currentUser = User()
        }
        return Singleton.currentUser
    }
    
    private(set) var bank_account: String!
    private(set) var debit_card: String!
    var first_name: String? = nil
    var middle_name: String!
    var last_name: String? = nil
    var name: String? = nil
    var address: String!
    var payment: PaymentSettings!
    var fbId: String!
    var phone_number: String!
    var profilePicture: UIImage? = nil
    var pastPurchases: [Item]!
    var email: String? = nil
    
    var orderHistory: NSArray? = nil
    
    init() {
        bank_account = "XXXXXXXXXXXXXXXX"
        debit_card = "XXXXXXXXXXXXXXXX"
        last_name = "Musk"
        name = "Elon Musk"
        address = "77 Main Street, North Adams, MA, 01247"
        payment = PaymentSettings.Debit
        if let token = FBSDKAccessToken.currentAccessToken() {
            self.fbId = token.userID
        }
        phone_number = "(112) 358-1321"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let email = userDefaults.objectForKey("UserEmail") as? String {
            self.email = email
        }
        if let fName = userDefaults.objectForKey("UserFName") as? String {
            first_name = fName
        } else if FBSDKAccessToken.currentAccessToken() != nil {
            first_name = FBSDKProfile.currentProfile().firstName
        }
        if let lName = userDefaults.objectForKey("UserLName") as? String {
            last_name = lName
        } else if FBSDKAccessToken.currentAccessToken() != nil {
            last_name = FBSDKProfile.currentProfile().lastName
        }
        name = first_name! + " " + last_name!
    }
    
    required init(first_name: String!, middle_name:String!, last_name: String!, address: String!){
        self.first_name = first_name
        self.middle_name = middle_name
        self.last_name = last_name
        self.address = address
        debit_card = "XXXXXXXXXXXXXXXX"
        bank_account = "XXXXXXXXXXXXXXXXXXXX"
        payment = PaymentSettings.Debit
        fbId = "0"
        phone_number = "(112) 358-1321"
    }
    
    func setBankAccount(bankAccount: String!){
        self.bank_account = bankAccount
    }
    
    func setDebitCard(debitCard: String!){
        self.debit_card = debitCard
    }
    
    func clearCurrentUser() {
        bank_account = nil
        debit_card = nil
        first_name = nil
        middle_name = nil
        last_name = nil
        address = nil
        fbId = nil
        phone_number = nil
        profilePicture = nil
        pastPurchases = nil
    }
}