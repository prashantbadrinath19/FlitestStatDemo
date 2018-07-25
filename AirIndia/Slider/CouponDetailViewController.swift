//
//  CouponDetailViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/21/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController {
    
    
    var couponNo: Int?
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblValidity: UILabel!
    
    @IBOutlet weak var lblCode: UILabel!
    
    
    //var couponDetailArr = [["Get Any seat at FLAT 20% off","07/19/2019","FLAT20"], ["Get 700 cashback on booking a trip with us","09/24/2019","CASHBACK700"], ["Get FLAT 10% off by using ICICI credit card","09/23/2018","BBICIC10"], ["Get 3000 off on traveling with us","02/28/2019","MMT3000"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if couponNo == 0
        {
            lblDescription.text = "Get Any seat at FLAT 20% off"
            lblValidity.text = "07/19/2019"
            lblCode.text = "FLAT20"
        }else if couponNo == 1
        {
            lblDescription.text = "Get 700 cashback on booking a trip with us"
            lblValidity.text = "09/24/2019"
            lblCode.text = "CASHBACK700"
        }else if couponNo == 2
        {
            lblDescription.text = "Get FLAT 10% off by using ICICI credit card"
            lblValidity.text = "09/23/2018"
            lblCode.text = "BBICIC10"
        }else if couponNo == 3
        {
            lblDescription.text = "Get 3000 off on traveling with us"
            lblValidity.text = "02/28/2019"
            lblCode.text = "MMT3000"
        }
        
    }

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
