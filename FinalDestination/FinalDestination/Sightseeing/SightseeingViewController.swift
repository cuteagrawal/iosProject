//
//  SightseeingViewController.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit
import MapKit

class SightseeingViewController: UIViewController, MKMapViewDelegate {

    var mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var tbLocation : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findPointsOfInterest()
    {
        print("Fetching")
        let poiRequest = MKLocalPointsOfInterestRequest(center: findNewLocation(prompt: tbLocation.text!), radius: 1000)
        
        let search = MKLocalSearch(request: poiRequest)
        search.start(completionHandler: {
            placemarks, error in
            self.mainDelegate.pointsOfInterest = placemarks!.mapItems
            self.performSegue(withIdentifier: "segueToPOIList", sender: nil)
        })
    }
    
    func findNewLocation(prompt : String) -> CLLocationCoordinate2D
    {
        let geocoder = CLGeocoder()
        var coord2D : CLLocationCoordinate2D!
        
        geocoder.geocodeAddressString(prompt, completionHandler: {
            placemarks, error in
            
            print(placemarks?.count)
            
            /*print("here")
            if error != nil { print("Error \(error.debugDescription)") }
            
            print("here2")
            let destination = placemarks?.first
            
            print("here3")
            coord2D = CLLocationCoordinate2D(latitude: (destination!.location?.coordinate.latitude)!, longitude: (destination!.location?.coordinate.longitude)!)*/

        })
        
        return coord2D
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
