//
//  CreditCardViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/17/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {

    @IBOutlet weak var tfFullName: UITextField!
    
    @IBOutlet weak var tfCardNo: UITextField!
    
    @IBOutlet weak var tfExpDate: UITextField!
    
    @IBOutlet weak var tfExpYear: UITextField!
    
    @IBOutlet weak var tfCVV: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnPayment(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
