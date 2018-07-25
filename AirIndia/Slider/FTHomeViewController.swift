//
//  FTHomeViewController.swift
//  AirIndia
//
//  Created by Prashant  Badrinath on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import SVProgressHUD

class FTHomeViewController: BaseViewController, flightSearchDelegate, pickDateDelegate {
    
    var allAirportsArr: Array<Airport> = []
    var flightArr: Array<ScheduledFlights> = []
    let formatter = DateFormatter()
    var tempFrom: String = ""
    var tempTo: String = ""
    var iataSource: String?
    var iataDestination: String?
    var dateOfJourney: String?

    @IBOutlet weak var lblAdult: UILabel!
    @IBOutlet weak var btnDeparture: UIButton!
    @IBOutlet weak var btnDestination: UIButton!
    @IBOutlet weak var btnDeparts: UIButton!
    @IBOutlet weak var btnReturns: UIButton!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var roundTripView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        navigationItem.hidesBackButton = true
        navigationItem.title = "Flight Search"
        btnDeparture.addTarget(self, action: #selector(selectDeparture), for: .touchUpInside)
        btnDestination.addTarget(self, action: #selector(selectDestination), for: .touchUpInside)
        btnDeparts.addTarget(self, action: #selector(selectDepart), for: .touchUpInside)
        btnReturns.addTarget(self, action: #selector(selectReturn), for: .touchUpInside)
        if segControl.selectedSegmentIndex == 0 {
            roundTripView.isHidden = true
        }
        fetchAllAirports()
        
        
    }
    
    func fetchAllAirports() {
        FirebaseHandler.sharedInstance.getAllAirports { (airport, error) in
            self.allAirportsArr = airport as! Array<Airport>
            print(self.allAirportsArr)
        }
    }
    
    func updateDeparture(strFrom: String, airportCode: String) {
        btnDeparture.setTitle(strFrom, for: .normal)
        iataSource = airportCode
    }
    
    func updateDestination(strTo: String, airportCode: String) {
        btnDestination.setTitle(strTo, for: .normal)
        iataDestination = airportCode
    }
    
    func updateDepartDate(departDate: String) {
        btnDeparts.setTitle(departDate, for: .normal)
    }
    
    func updateReturnDate(returnDate: String) {
        btnReturns.setTitle(returnDate, for: .normal)
    }
    
    func getCurrentDate(currDate: String) {
        dateOfJourney = currDate
    }
    
    @objc func selectDeparture(sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "FlightSearchViewController") as? FlightSearchViewController {
            controller.flightsArr = allAirportsArr
            controller.delegateFlight = self
            controller.fromSelectTag = sender.tag
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func selectDestination(sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "FlightSearchViewController") as? FlightSearchViewController {
            controller.flightsArr = allAirportsArr
            controller.delegateFlight = self
            controller.toSelectTag = sender.tag
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func selectDepart(sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
            controller.delegateDate = self
            controller.departSelectTag = sender.tag
            navigationController?.present(controller, animated: true, completion: nil)
        }
    }
    
    @objc func selectReturn(sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
            controller.returnSelectTag = sender.tag
            navigationController?.present(controller, animated: true, completion: nil)
        }
    }
 
    @IBAction func btnExchange(_ sender: UIButton) {
        let btnDepartureText = btnDeparture.titleLabel?.text
        btnDeparture.setTitle(btnDestination.titleLabel?.text, for: .normal)
        btnDestination.setTitle(btnDepartureText, for: .normal)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            roundTripView.isHidden = false
        } else {
            roundTripView.isHidden = true
        }
    }
    
    @IBAction func adultStepper(_ sender: UIStepper) {
        let adultCount = Int(sender.value)
        lblAdult.text = "\(adultCount) Adults"
    }
    
    
    @IBAction func btnSearchFlight(_ sender: Any) {
        SVProgressHUD.show()
        if let controller = storyboard?.instantiateViewController(withIdentifier: "FindFlightsViewController") as? FindFlightsViewController {
            WebServiceHandler.sharedInstance.getFlightData(from: iataSource!, to: iataDestination!, departing: dateOfJourney!) { (jsonArr, error) in
                if error == nil {
                    controller.findFlightArr = (jsonArr?.scheduledFlights)!
                } else {
                    print(error?.localizedDescription)
                }
                //self.navigationController?.pushViewController(controller, animated: true)
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
