//
//  Users.swift
//  AirIndia
//
//  Created by Cheeja on 6/18/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import Foundation

class User {
    let EmailID: String?
    let UserID: String?
    let FullName: String?
    let Gender: String?
    let PhoneNo: String?
    let UserImage: String?
    var Transactions: [String] = []
    
    init(EmailID: String, UserID: String, FullName: String, Gender: String, PhoneNo: String, UserImage: String, Transactions: [String]) {
        self.EmailID = EmailID
        self.UserID = UserID
        self.FullName = FullName
        self.Gender = Gender
        self.PhoneNo = PhoneNo
        self.UserImage = UserImage
        self.Transactions = Transactions
    }
}
