//
//  FlightData.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

/**
 *  NSObject to  hold the data of Flights for the Flight history
 */

class FlightData: NSObject {

    var id: Int? // Stores ID for Database usage
    var airlineName: String? // Stores the airline name
    var flightCode: String? // Stores the flight number
    var departureAirportCode: String? // stores the departure airport code - Example YYZ
    var arrivalAirportCode: String? // stores the arrival airport code
    
    // Constructor for initialization
    func initWithData(theRow  i:Int, airlineName an:String,
                      theFlightCode fn:String, departureAirportCode depCd:String,
                      arrivalAirportCode arrCd:String){
        id = i
        airlineName = an
        flightCode = fn
        departureAirportCode = depCd
        arrivalAirportCode = arrCd
    }
}
