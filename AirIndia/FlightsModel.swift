//
//  FlightsModel.swift
//  AirIndia
//
//  Created by Cheeja on 6/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import Foundation

struct JSON: Codable {
    var request: Request
    var scheduledFlights: [ScheduledFlights]
}

struct Request: Codable {
    var codeType: CodeType
}

struct CodeType: Codable{
    var requested: String
    var interpreted: String
}

struct ScheduledFlights: Codable {
    var flightNumber: String
    var departureAirportFsCode: String
    var arrivalAirportFsCode: String
    var departureTime: String
    var arrivalTime: String
}
