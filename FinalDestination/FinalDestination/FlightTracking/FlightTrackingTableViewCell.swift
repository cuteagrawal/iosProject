//
//  FlightTrackingTableViewCell.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit
/**
 * TableViewCell class for the Flight history Table
 */
class FlightTrackingTableViewCell: UITableViewCell {
    
    // Declaring all labels as IB outlets
    @IBOutlet var departureAirportCodeLbl: UILabel! // flight Departing airport code
    @IBOutlet var arrivalAirportCodeLbl: UILabel! // flight arrival airport code
    @IBOutlet var airlineAndFlightLbl: UILabel! // will hold the airline name and the flight number
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
