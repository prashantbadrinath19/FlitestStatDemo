//
//  TransactionsViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/17/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TransactionsViewController: BaseViewController {

    var transactionArr: Array<Transactions> = []
    var currUser = Auth.auth().currentUser?.uid
    var databaseRef = Database.database().reference()
    
    @IBOutlet weak var transTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransactions()
    }
    
    func fetchTransactions() {
        FirebaseHandler.sharedInstance.getSingleUser(userID: currUser!) { (user) in
            if user.Transactions.count > 0 {
                FirebaseHandler.sharedInstance.getTransactions(transactions: user.Transactions, completion: { (trans) in
                    self.transactionArr = trans
                    self.transTblView.reloadData()
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell") as? TransactionsTableViewCell
        let transData = transactionArr[indexPath.row]
        cell?.lblFlightNo.text = transData.FlightNo
        cell?.lblSource.text = transData.FlightSource
        cell?.lblDest.text = transData.FlightDestination
        cell?.lblSchedule.text = transData.FlightTime
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            databaseRef.child("Transactions").child(transactionArr[indexPath.row].TransactionID!).removeValue()
            databaseRef.child("Users").child(currUser!).child("Transactions").child(transactionArr[indexPath.row].TransactionID!).removeValue()
            
            transactionArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
    }
}
