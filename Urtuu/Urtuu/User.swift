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
    var first_name: String!
    var middle_name: String!
    var last_name: String!
    var address: String!
    var payment: PaymentSettings!
    var fbId: String!
    var phone_number: String!
    var profilePicture: UIImage? = nil
    var pastPurchases: [Item]!
    
    init() {
        bank_account = "XXXXXXXXXXXXXXXX"
        debit_card = "XXXXXXXXXXXXXXXX"
        first_name = "Elon"
        last_name = "Musk"
        address = "77 Main Street, North Adams, MA, 01247"
        payment = PaymentSettings.Debit
        fbId = "0"
        phone_number = "(112) 358-1321"
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