//
//  WebServiceHandler.swift
//  AirIndia
//
//  Created by Cheeja on 6/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import Foundation

let appId = "c115516e"
let appKey = "c32f078ed6c7febc87f52824670d1177"
let flightApi = "https://api.flightstats.com/flex/schedules/rest/v1/json/from/%@/to/%@/departing/%@?appId=%@&appKey=%@&codeType=IATA"


typealias completionHandler = (JSON?, Error?) -> ()

class WebServiceHandler: NSObject {
    private override init() {}
    static let sharedInstance = WebServiceHandler()
    
    func getFlightData(from: String, to: String, departing: String, completion: @escaping completionHandler) {
        let urlStr = String(format: flightApi, from, to, departing, appId, appKey)
        let url = URL(string: urlStr)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error ==  nil {
                do {
                    let decodedData = try JSONDecoder().decode(JSON.self, from: data!)
                    //print(decodedData.scheduledFlights[0].flightNumber)
                    completion(decodedData,nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
