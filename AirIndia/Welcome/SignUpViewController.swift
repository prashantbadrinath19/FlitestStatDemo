//
//  SignUpViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import FirebaseAuth
import TWMessageBarManager
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    var userRef: DatabaseReference?

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isHidden = true
        userRef = Database.database().reference().child("Users")
    }
    
    @IBAction func btnCreateAcc(_ sender: Any) {
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { (result, error) in
            
            if let err = error {
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
            } else {
                TWMessageBarManager().showMessage(withTitle: "Success", description: "Account Created", type: .success)
                self.navigationController?.popViewController(animated: true)
                
                if let firstUser = result?.user {
                    let userDict = ["UserID": firstUser.uid, "EmailID": self.tfEmail.text!, "FullName": self.tfFullName.text!, "Gender": self.tfGender.text!, "PhoneNo": self.tfPhoneNo.text!, "UserImage": ""]
                    self.userRef?.child(firstUser.uid).updateChildValues(userDict, withCompletionBlock: { (error, ref) in
                        if let err = error {
                            TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
