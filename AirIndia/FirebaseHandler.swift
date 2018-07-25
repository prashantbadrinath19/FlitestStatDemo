//
//  FirebaseHandler.swift
//  AirIndia
//
//  Created by Ady on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import Foundation
import FirebaseDatabase
import TWMessageBarManager

typealias airportCompletionHandler = ([Airport?], Error?) -> ()
typealias transactionCompletionHandler = ([Transactions]) -> ()
typealias singleUserCompletionHandler = (User) -> ()

class FirebaseHandler: NSObject {
    
    var databaseRef: DatabaseReference = Database.database().reference()
    
    private override init() {}
    static let sharedInstance = FirebaseHandler()
    
    func getAllAirports(completion: @escaping airportCompletionHandler) {
        
        databaseRef.child("Airports").observeSingleEvent(of: .value) { (snapshot) in
            var airportArr : Array<Airport> = []
            
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            
            for item in value {
                let dict = item.value as! Dictionary<String, Any>
                let airPortData = Airport(name: dict["name"] as! String, iata: dict["iata"] as! String, city: dict["city"] as! String)
                airportArr.append(airPortData)
            }
            completion(airportArr,nil)
        }
    }
    
    func getSingleUser(userID: String, completion: @escaping singleUserCompletionHandler)
    {
        databaseRef.child("Users/\(userID)").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? Dictionary<String,Any> else {
                return
            }
            var obj: User?
            var userTransArr : Array<String> = []
            if let userTransDict = value["Transactions"] as? [String: Bool] {
                for val in userTransDict {
                    userTransArr.append(val.key)
                }
            }
            
            obj = User(EmailID: (value["EmailID"] as! String), UserID: userID, FullName: (value["FullName"] as! String), Gender: (value["Gender"] as! String), PhoneNo: (value["PhoneNo"] as? String)!, UserImage: (value["UserImage"] as? String)!, Transactions: userTransArr)
            
            completion(obj!)
        }
    }
    
    func getTransactions(transactions: [String], completion: @escaping (([Transactions]) -> Void)) {
        
        var transArr: [Transactions] = []
        for item in transactions{
            databaseRef.child("Transactions").child(item).observeSingleEvent(of: .value) { (snapshot) in
                guard let value = snapshot.value as? Dictionary<String, Any> else
                {
                    completion([])
                    return
                }
                
                let transData = Transactions(TransactionID: value["TransactionID"] as! String, FlightNo: value["FlightNo"] as! String, FlightSource: value["FlightSource"] as! String, FlightDestination: value["FlightDestination"] as! String, FlightTime: value["FlightTime"] as! String)
                transArr.append(transData)
                completion(transArr)
            }
        }
    }
}

