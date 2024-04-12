//
//  SightseeingViewController.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit
import MapKit

class SightseeingViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    var mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var tbLocation : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func unwindToSightseeingVC (sender: UIStoryboardSegue) { }
    
    @IBAction func findPointsOfInterest()
    {
        print("Fetching")
        
        if tbLocation.text!.count <= 0 { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(tbLocation.text!, completionHandler: {
            placemarks, error in
            
            let location = (placemarks?.first)!
            
            let poiRequest = MKLocalPointsOfInterestRequest(center: location.location!.coordinate, radius: 1000)
            
            let search = MKLocalSearch(request: poiRequest)
            search.start(completionHandler: {
                placemarks, error in
                self.mainDelegate.pointsOfInterest = placemarks!.mapItems
                self.performSegue(withIdentifier: "segueToPOIList", sender: nil)
            })
        })
    }
    
    @IBAction func findPointsOfInterestByUserLocation()
    {
        print("Fetching")
        
        let LocationManager = CLLocationManager()
        LocationManager.requestWhenInUseAuthorization()
        
        var currentLocation : CLLocation!
        
        if LocationManager.authorizationStatus == .authorizedWhenInUse || LocationManager.authorizationStatus == .authorizedAlways
        {
            currentLocation = LocationManager.location
            
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
                placemarks, error in
                
                let location = (placemarks?.first)!
                
                let poiRequest = MKLocalPointsOfInterestRequest(center: location.location!.coordinate, radius: 1000)
                
                let search = MKLocalSearch(request: poiRequest)
                search.start(completionHandler: {
                    placemarks, error in
                    self.mainDelegate.pointsOfInterest = placemarks!.mapItems
                    self.performSegue(withIdentifier: "segueToPOIList", sender: nil)
                })
            })
        }
        else
        {
            let alert = UIAlertController(title: "Location Services Disabled", message: "It seems like you have disabled Location Services, please enable them and try again.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .cancel)
            
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
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
