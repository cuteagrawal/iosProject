//
//  FlightTrackingTableViewCell.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

class FlightTrackingTableViewCell: UITableViewCell {
    
    @IBOutlet var departureAirportCodeLbl: UILabel!
    @IBOutlet var arrivalAirportCodeLbl: UILabel!
    @IBOutlet var airlineAndFlightLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
