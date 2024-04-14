//
//  FlightTrackingTableViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

/**
 * ViewController which will show the previously searched flights in a table format in the search history page for flights
 */
class FlightTrackingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // appDelegate instance to retrieve the flightarray and database functionality
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // variable to hold table cell height
    let cellHeight: CGFloat = 120
    
    // table
    @IBOutlet var flightTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // read values from DB using appdelegate and update array along with assigning null to viewFlight
        mainDelegate.readFlightDataFromDatabase()
        mainDelegate.viewFlight = nil
        
    }
    // This sets the number of rows that will be shown
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.flightArr.count
    }
    
    // This sets the cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    // populating the cell with data retrieved from the DB
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : FlightTrackingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FlightTrackingTableViewCell")
        as? FlightTrackingTableViewCell ?? FlightTrackingTableViewCell(style: .default, reuseIdentifier: "FlightTrackingTableViewCell")
        
        // setting up the variables to hold the values from db
        let rowNum = indexPath.row
        let airline: String = mainDelegate.flightArr[rowNum].airlineName ?? ""
        let flightCode: String = mainDelegate.flightArr[rowNum].flightCode ?? ""
        let airlineAndFlight = "\(airline) \(flightCode)" // combining the airline name and flight number in a string
        
        // setting up the labels inside the individual table cell to show the values
        tableCell.departureAirportCodeLbl.text = mainDelegate.flightArr[rowNum].departureAirportCode
        tableCell.arrivalAirportCodeLbl.text = mainDelegate.flightArr[rowNum].arrivalAirportCode
        tableCell.airlineAndFlightLbl.text = airlineAndFlight
        

        return tableCell
    }


}
