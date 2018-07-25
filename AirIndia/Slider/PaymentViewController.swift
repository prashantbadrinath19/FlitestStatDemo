//
//  PaymentViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/17/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PaymentViewController: UIViewController, PayPalPaymentDelegate {
    
    var resultText = ""
    var payPalConfig = PayPalConfiguration()
    var currentUserID = Auth.auth().currentUser?.uid
    var databaseRef: DatabaseReference?
    var key = ""
    
    var flightNo: String?
    var flightSource: String?
    var flightDestination: String?
    var flightTime: String?
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        key = (databaseRef?.child("Transactions").childByAutoId().key)!
        storeTransactions()

        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = "Air India, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            self.resultText = completedPayment.description
            //self.showSuccess()
        })
    }
    
    @IBAction func btnPayPal(_ sender: UIButton) {
        let item = PayPalItem(name: "Flight", withQuantity: 1, withPrice: NSDecimalNumber(string: "172.14"), withCurrency: "USD", withSku: "Flight-0001")
        let items = [item]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        let total = subtotal.adding(shipping).adding(tax)
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Flight Booking", intent: .sale)
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let controller = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(controller!, animated: true, completion: nil)
        } else {
            print("Payment not processable: \(payment)")
        }
    }
    
    func storeTransactions() {
        if Auth.auth().currentUser != nil {
            let transaction = ["TransactionID": self.key, "FlightNo": flightNo , "FlightSource": flightSource, "FlightDestination": flightDestination, "FlightTime": flightTime]
            self.databaseRef?.child("Transactions").child(self.key).updateChildValues(transaction)
            
            let transactionForCurUser = [self.key: true]
            self.databaseRef?.child("Users").child(self.currentUserID!).child("Transactions").updateChildValues(transactionForCurUser)
        }
    }
    
    
    @IBAction func confirmPayment(_ sender: Any) {
        let paymentAlert = UIAlertController(title: "Payment Successful", message: "", preferredStyle: .alert)
        let paymentAlertAction = UIAlertAction(title: "OK", style: .default)
        paymentAlert.addAction(paymentAlertAction)
        present(paymentAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
