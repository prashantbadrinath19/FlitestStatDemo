//
//  SignInViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import FirebaseAuth
import TWMessageBarManager
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    var databaseRef: DatabaseReference?
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference().child("airport")
    }

    @IBAction func btnSignIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { (result, error) in
            if let err = error {
                
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
            } else {
                TWMessageBarManager().showMessage(withTitle: "Success", description: "Signed in", type: .success)
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "ECSlidingViewController")
                    self.present(controller, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
