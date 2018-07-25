//
//  FlightSearchViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/12/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

@objc protocol flightSearchDelegate {
    func updateDeparture(strFrom: String, airportCode: String)
    func updateDestination(strTo: String, airportCode: String)
}

class FlightSearchViewController: UIViewController, UISearchBarDelegate {
    
    var flightsArr: Array<Airport> = []
    var delegateFlight: flightSearchDelegate?
    var fromSelectTag: Int?
    var toSelectTag: Int?
    var originalArr : Array<Airport> = []
    
    @IBOutlet weak var tblViewFlightSearch: UITableView!
    @IBOutlet weak var searchBarFlight: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalArr = flightsArr
        // Do any additional setup after loading the view.
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        flightsArr = originalArr
        searchBar.text = ""
        tblViewFlightSearch.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if !text.isEmpty{
                print("Search")
                flightsArr = originalArr.filter({($0.city.uppercased().contains(text.uppercased()))})
            }
        }
        tblViewFlightSearch.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            flightsArr = originalArr
            tblViewFlightSearch.reloadData()
            searchBar.resignFirstResponder()
        } else {
            if let text = searchBar.text {
                if !text.isEmpty{
                    print("Search")
                    flightsArr = originalArr.filter({($0.city.uppercased().contains(text.uppercased()))})
                }
            }
            tblViewFlightSearch.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FlightSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightSearch")
        let flightData = flightsArr[indexPath.row]
        cell?.textLabel?.text = flightData.city
        cell?.detailTextLabel?.text = flightData.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let flightData = flightsArr[indexPath.row]
            if fromSelectTag == 1 {
                delegateFlight?.updateDeparture(strFrom: flightData.city + ", " + flightData.name, airportCode: flightData.iata)
            } else if toSelectTag == 2 {
                delegateFlight?.updateDestination(strTo: flightData.city + ", " + flightData.name, airportCode: flightData.iata)
            }
        
            navigationController?.popViewController(animated: true)
    }
}
