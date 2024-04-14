//
//  SightseeingViewController.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit
import MapKit

class SightseeingViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    
    //Access the main delegate so the Point of Interests table can be used
    var mainDelegate = UIApplication.shared.delegate as! AppDelegate

    //Text Field for the location of the user
    @IBOutlet var tbLocation : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Allow the keyboard to disappear after pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    //An unwind segue to unwind the view controllers
    @IBAction func unwindToSightseeingVC (sender: UIStoryboardSegue) { }
    
    //Use the location the user provided in the Text Field tbLocation to find Points of Interest in the area
    @IBAction func findPointsOfInterest()
    {
        print("Fetching")
        
        if tbLocation.text!.count <= 0 { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(tbLocation.text!, completionHandler: {
            placemarks, error in
            
            if (placemarks?.first == nil)
            {
                let alert = UIAlertController(title: "Location Not Found", message: "This location doesn't seem to exist, please check the spelling and try again.", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Okay", style: .cancel)
                
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
                
                return
            }
            
            let location = (placemarks?.first)!
            
            let poiRequest = MKLocalPointsOfInterestRequest(center: location.location!.coordinate, radius: 1000)
            
            let search = MKLocalSearch(request: poiRequest)
            search.start(completionHandler: {
                placemarks, error in
                
                var placemarkList = placemarks?.mapItems
                placemarkList?.remove(at: 0)
                
                self.mainDelegate.pointsOfInterest = placemarkList!
                self.performSegue(withIdentifier: "segueToPOIList", sender: nil)
            })
        })
    }
    
    //Find Points of Interest based on the users cell phone location
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
