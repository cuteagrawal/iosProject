//
//  FlightTrackingViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

class FlightTrackingViewController: UIViewController {
    // YYZ, YUL, LAX, etc..
    @IBOutlet var departureAirportCodeLbl: UILabel!
    @IBOutlet var arrivalAirportCodeLbl: UILabel!
    
    // Search Box
    @IBOutlet var flightSearchTxtFld: UITextField!
    
    // Timings
    @IBOutlet var departureTimeLbl: UILabel!
    @IBOutlet var arriveTimeLbl: UILabel!
    
    // Sched, live, landed etc..
    @IBOutlet var flightStatusLbl: UILabel!
    
    //Toronto to Montreal, Abu Dhabi to Los Angeles etc...
    @IBOutlet var flightPlanCitiesLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Search function
    @IBAction func searchFlight(sender: UIButton){
        
    }
    
    // Unwins segue
    @IBAction func unwindToFlightTrackingVC (sender: UIStoryboardSegue) { }
    
    // Add to calendar action
    @IBAction func addToCalendar(sender: UIButton){
        
    }
    
}
