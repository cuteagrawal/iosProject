//
//  FlightTrackingTableViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//

import UIKit

class FlightTrackingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellHeight: CGFloat = 120
    
    @IBOutlet var flightTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainDelegate.readFlightDataFromDatabase()
        mainDelegate.viewFlight = nil
        print(mainDelegate.flightArr)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.flightArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : FlightTrackingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FlightTrackingTableViewCell")
        as? FlightTrackingTableViewCell ?? FlightTrackingTableViewCell(style: .default, reuseIdentifier: "FlightTrackingTableViewCell")
        
        let rowNum = indexPath.row
        let airline: String = mainDelegate.flightArr[rowNum].airlineName ?? ""
        let flightCode: String = mainDelegate.flightArr[rowNum].flightCode ?? ""
        let airlineAndFlight = "\(airline) \(flightCode)"
        tableCell.departureAirportCodeLbl.text = mainDelegate.flightArr[rowNum].departureAirportCode
        tableCell.arrivalAirportCodeLbl.text = mainDelegate.flightArr[rowNum].arrivalAirportCode
        tableCell.airlineAndFlightLbl.text = airlineAndFlight
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }


}
