//
//  SightseeingTableViewController.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit
import MapKit

class SightseeingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.pointsOfInterest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : POITableViewCell = tableView.dequeueReusableCell(withIdentifier: "POICell") as? POITableViewCell ?? POITableViewCell(style: .default, reuseIdentifier: "POICell")
        
        let rowNum = indexPath.row
        
        tableCell.locationName.text =  mainDelegate.pointsOfInterest[rowNum].name
        
        return tableCell
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
