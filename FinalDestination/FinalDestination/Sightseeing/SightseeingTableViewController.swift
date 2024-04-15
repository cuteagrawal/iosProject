//
//  SightseeingTableViewController.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit
import MapKit

class SightseeingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Accesses the main delegate of the application so the Points of Interest table can be used
    var mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Outlet the Table View so we can modify properties
    @IBOutlet var tbPointsOfInterest : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var background = UIImageView(image: UIImage(named: "sunset.jpeg"))
        background.contentMode = .scaleAspectFill
        
        tbPointsOfInterest.backgroundView = background
    }
    
    
    //Sets the total number of rows in the Table View using the Points of Interest table count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.pointsOfInterest.count
    }
    
    //Sets the height for each cell in the Table View to 100
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //Loops through the data in the Points of Interest table and creates table cells for each entry and displays their name, category and phone number
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : POITableViewCell = tableView.dequeueReusableCell(withIdentifier: "POICell") as? POITableViewCell ?? POITableViewCell(style: .default, reuseIdentifier: "POICell")
        
        let rowNum = indexPath.row
        
        tableCell.locationName.text =  mainDelegate.pointsOfInterest[rowNum].name
        
        let category = mainDelegate.pointsOfInterest[rowNum].pointOfInterestCategory?.rawValue.components(separatedBy: "Category")
        
        tableCell.locationType.text = String(category?[1] ?? "Unknown")
        
        tableCell.locationPhoneNumber.text = mainDelegate.pointsOfInterest[rowNum].phoneNumber ?? "No Phone Number Provided"
        
        tableCell.accessoryType = .disclosureIndicator
        
        tableCell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        
        return tableCell
    }
    
    
    //This function opens the users maps application with the address of the Point of Interest when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate.pointsOfInterest[indexPath.row].openInMaps()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
