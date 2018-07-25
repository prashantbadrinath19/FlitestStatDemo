//
//  FindFlightsViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/15/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import SVProgressHUD

class FindFlightsViewController: UIViewController {
    
    var findFlightArr: Array<ScheduledFlights> = []
    
    @IBOutlet weak var tblViewFindFlights: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        DispatchQueue.main.async {
            self.tblViewFindFlights.reloadData()
            print(self.findFlightArr)
        }
    }

    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FindFlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.dismiss()
        return findFlightArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell") as? FindFlightsTableViewCell
        let flightDetails = findFlightArr[indexPath.row]
        cell?.lblFlightNo.text = flightDetails.flightNumber
        cell?.lblDepartureCode.text = flightDetails.departureAirportFsCode + " ~> " + flightDetails.arrivalAirportFsCode
        cell?.lblArrivalCode.text = flightDetails.departureTime
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            let flightDetails = findFlightArr[indexPath.row]
            controller.flightNo = flightDetails.flightNumber
            controller.flightSource = flightDetails.departureAirportFsCode
            controller.flightDestination = flightDetails.arrivalAirportFsCode
            controller.flightTime = flightDetails.departureTime
            present(controller, animated: true, completion: nil)
        }
        
    }
}
