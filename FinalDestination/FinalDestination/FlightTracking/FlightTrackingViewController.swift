//
//  FlightTrackingViewController.swift
//  FinalDestination
//
//  Created by Feby Jomy on 4/13/24.
//
//  Reference :
//      https://rapidapi.com/flightera/api/flightera-flight-data
//      https://developer.apple.com/documentation/foundation/dateformatter
//      https://stackoverflow.com/questions/40777416/ekeventstore-access-request-crashes-on-ios-10-messagethe-apps-info-plist-must
//
//


import UIKit
import Foundation
import EventKit

class FlightTrackingViewController: UIViewController, UITextFieldDelegate{
    
    // appDelegate instance to add values to DB
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // label for IATA codes (YYZ, YUL, LAX, etc..)
    @IBOutlet var departureAirportCodeLbl: UILabel!
    @IBOutlet var arrivalAirportCodeLbl: UILabel!
    
    // Search Box
    @IBOutlet var flightSearchTxtFld: UITextField!
    
    // Timings labels
    @IBOutlet var departureTimeLbl: UILabel!
    @IBOutlet var arriveTimeLbl: UILabel!
    
    // label for status (Sched, live, landed etc..)
    @IBOutlet var flightStatusLbl: UILabel!
    
    // label for fligh plan (Toronto to Montreal, Abu Dhabi to Los Angeles etc...)
    @IBOutlet var flightPlanCitiesLbl: UILabel!
    
    //label for airline Name and flightnumber (example AirCanada AC787)
    @IBOutlet var airlineAndFlightLbl: UILabel!
    
    // Dictionary to store the api response
    var apiResponse:[String:String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // function to update the labels with the api information
    func updateLabels(){
        // updating labels for IATA codes
        print(apiResponse)
        arrivalAirportCodeLbl.text = apiResponse["arrival_iata"]
        departureAirportCodeLbl.text = apiResponse["departure_iata"]
        
        //updating arrival and departure time labels
        if let arriveTime = formatTimeString(String(describing: apiResponse["scheduled_arrival_local"] ?? "")){
            arriveTimeLbl.text = arriveTime
        }
        if let departTime = formatTimeString(String(describing: apiResponse["scheduled_departure_local"] ?? "")){
            departureTimeLbl.text = departTime
        }
        
        //updating status
        flightStatusLbl.text = apiResponse["status"]?.capitalized
        
        //updating airline and flight number
        airlineAndFlightLbl.text =
        "\(String(describing: apiResponse["airline_name"] ?? "")) \(String(describing: apiResponse["flnr"] ?? ""))"
        
        //updating flight plan (cities)
        flightPlanCitiesLbl.text =
        "\(String(describing: apiResponse["departure_city"] ?? "")) to \(String(describing: apiResponse["arrival_city"] ?? ""))"
        
    }
    
    // function to add the searched information to Database
    func addInfoToDB(){
        
        // initializing data classwith all data needed
        var flight:FlightData = .init()
        flight.initWithData(theRow: 0, airlineName: apiResponse["airline_name"] ?? "", theFlightCode: apiResponse["flnr"] ?? "", departureAirportCode: apiResponse["departure_iata"] ?? "", arrivalAirportCode: apiResponse["arrival_iata"] ?? "")
        
        // inserting into DB
        if (mainDelegate.insertFlightDataIntoDatabase(flight: flight)){
            print("Insert complete")
        }
    }
    
    // function to convert timestamps into required local format for the labels
    func formatTimeString(_ dateString: String) -> String? {
        //dateformatter instance
        let dateFormatter = DateFormatter()
        // providing the input date-time format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = dateFormatter.date(from: dateString) {
            // required format
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: date)
        } else {
            print("Invalid date string")
            return nil
        }
    }
    
    // Search function
    @IBAction func searchFlight(sender: UIButton){
        let searchFlight = flightSearchTxtFld.text ?? ""
        
        if (searchFlight == ""){
            print("Empty string in search")
        }else{
            rapidAPICall(searchedFlightNumber: searchFlight)
        }
    }
    
    // Unwins segue
    @IBAction func unwindToFlightTrackingVC (sender: UIStoryboardSegue) { }
    
    // Add to calendar action
    @IBAction func addToCalendar(sender: UIButton){
        createCalendarEvent(startTimestampString: apiResponse["scheduled_departure_utc"] ?? ""
                            ,endTimestampString: apiResponse["scheduled_arrival_utc"] ?? "")
    }
    
    // creating a calendar event
    func createCalendarEvent(startTimestampString: String, endTimestampString: String){
        // Create an Event Store instance
        let eventStore = EKEventStore()
        
        // Request access to the user's calendar
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if granted && error == nil {
                
                // Access granted, create the event
                let event = EKEvent(eventStore: eventStore)
                event.title = "Your Event Title"
                
                // Convert timestamp strings to Date objects
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                
                guard let startDate = dateFormatter.date(from: startTimestampString),
                      let endDate = dateFormatter.date(from: endTimestampString) else {
                    print("Error: Unable to parse timestamps.")
                    return
                }
                
                event.startDate = startDate
                event.endDate = endDate
                
                // Save the event to the calendar
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    print("Event saved successfully.")
                } catch let error {
                    print("Error saving event: \(error.localizedDescription)")
                }
            } else {
                // Access denied or error occurred
                print("Error: Access to calendar not granted.")
            }
        }
        
    }
    
    // calling the rapid api for fligh tracking
    func rapidAPICall(searchedFlightNumber:String){
        
        // request headers with the key and host information
        let headers = [
            "X-RapidAPI-Key": "497bf66c53msh141f64710aeb171p1dae5ejsne8483b04b307",
            "X-RapidAPI-Host": "flightera-flight-data.p.rapidapi.com"
        ]
        
        //building the request
        let request = NSMutableURLRequest(url: NSURL(string: "https://flightera-flight-data.p.rapidapi.com/flight/info?flnr=\(searchedFlightNumber)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        // rest method
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    // everything is ok if response is 200
                    print("Status code: \(httpResponse.statusCode)")
                    if let jsonData = data {
                        do {
                            // Parsing JSON data
                            if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                                
                                for flightInfo in jsonArray {
                                    
                                    // storing the response into the dictionary
                                    self.apiResponse = ["airline_name": "\(flightInfo["airline_name"] ?? "N/A")",
                                                        "flnr": "\(flightInfo["flnr"] ?? "N/A")",
                                                        "departure_iata": "\(flightInfo["departure_iata"] ?? "N/A")",
                                                        "arrival_iata": "\(flightInfo["arrival_iata"] ?? "N/A")",
                                                        "status": "\(flightInfo["status"] ?? "N/A")",
                                                        "departure_city": "\(flightInfo["departure_city"] ?? "N/A")",
                                                        "arrival_city": "\(flightInfo["arrival_city"] ?? "N/A")",
                                                        "scheduled_arrival_local": "\(flightInfo["scheduled_arrival_local"] ?? "N/A")",
                                                        "scheduled_arrival_utc": "\(flightInfo["scheduled_arrival_utc"] ?? "N/A")",
                                                        "scheduled_departure_utc": "\(flightInfo["scheduled_departure_utc"] ?? "N/A")",
                                                        "scheduled_departure_local": "\(flightInfo["scheduled_departure_local"] ?? "N/A")"]
                                }
                                // Update labels on the main thread after processing the API response
                                DispatchQueue.main.async {
                                    self.updateLabels()
                                    self.addInfoToDB()
                                }
                            }
                        } catch let parseError {
                            print("Error parsing JSON: \(parseError)")
                        }
                    }
                    
                }
            }
        })
        
        dataTask.resume()
    }
}
