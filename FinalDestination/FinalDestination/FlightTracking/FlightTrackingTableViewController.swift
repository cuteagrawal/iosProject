//
//  FlightTrackingTableViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

class FlightTrackingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // appDelegate instance to retrieve the flightarray and database functionality
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // variable to hold table cell height
    let cellHeight: CGFloat = 120
    
    // table
    @IBOutlet var flightTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // read values from DB and update array
        mainDelegate.readFlightDataFromDatabase()
        mainDelegate.viewFlight = nil
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.flightArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    // populating the cell with data retrieved from the D
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : FlightTrackingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FlightTrackingTableViewCell")
        as? FlightTrackingTableViewCell ?? FlightTrackingTableViewCell(style: .default, reuseIdentifier: "FlightTrackingTableViewCell")
        
        // setting up the variables to hold the values from db
        let rowNum = indexPath.row
        let airline: String = mainDelegate.flightArr[rowNum].airlineName ?? ""
        let flightCode: String = mainDelegate.flightArr[rowNum].flightCode ?? ""
        let airlineAndFlight = "\(airline) \(flightCode)"
        
        // setting up the labels inside the individual table cell to show the values
        tableCell.departureAirportCodeLbl.text = mainDelegate.flightArr[rowNum].departureAirportCode
        tableCell.arrivalAirportCodeLbl.text = mainDelegate.flightArr[rowNum].arrivalAirportCode
        tableCell.airlineAndFlightLbl.text = airlineAndFlight
        

        return tableCell
    }


}
