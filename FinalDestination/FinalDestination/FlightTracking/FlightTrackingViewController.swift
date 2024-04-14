//
//  FlightTrackingViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

class FlightTrackingViewController: UIViewController {
    @IBOutlet var departureAirportCodeLbl: UILabel!
    @IBOutlet var arrivalAirportCodeLbl: UILabel!
    @IBOutlet var flightSearchTxtFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Unwins segue
    @IBAction func unwindToFlightTrackingVC (sender: UIStoryboardSegue) { }

}
