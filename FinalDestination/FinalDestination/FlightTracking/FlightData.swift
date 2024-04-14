//
//  FlightData.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit


class FlightData: NSObject {

    var id: Int?
    var airlineName: String?
    var flightCode: String?
    var departureAirportCode: String?
    var arrivalAirportCode: String?
    
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
