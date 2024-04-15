//
//  AppDelegate.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-03-31.
//  Modified by Jay Patel on 2024-04-09.
//  Modified by Feby Jomy on 20234-04-13.
//  Modified by Jacob on 20234-04-13.
//

import UIKit
import SQLite3
import MapKit
/**
 * This is App delegate
 * This is where the database connection is made and shared bewteen different view controllers
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Database name saved in a vaible
    var databaseName : String = "FinalDestination.db"
    // Path Array
    var databasePath : String = ""
    // Twitter Array
    var tweetArr : [TweetData] = []
    // Point of Inetest array to save locations
    var pointsOfInterest : [MKMapItem] = []
    // Budget data array
    var budgetArr : [BudgetData] = []
    var viewBudget : BudgetData? = nil
    // FLight data array
    var flightArr: [FlightData] = []
    var viewFlight: FlightData? = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        
        databasePath = documentsDir.appending("/" + databaseName)
        print("location is: " + databasePath)
        
        // called to read the data
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    
    // Finds the database
    func checkAndCreateDatabase(){
        
        var success = false
        var fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath)
        
        if success{
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath)
        
    }
    
    // Reads the Flight data from the database
    func readFlightDataFromDatabase(){
        flightArr.removeAll()
        var db:OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            
            print("successfully opened database at \(self.databasePath)")
            var queryStatement : OpaquePointer? = nil
            
            let flightQuery: String = "select * from flights"
            
            // Flight data query here
            if(sqlite3_prepare_v2(db, flightQuery, -1, &queryStatement, nil)) == SQLITE_OK{
                while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    // Flight data class
                    let dataFlight: FlightData = .init()
                    
                    // getting previous search flight details from db
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let airLineName: String = String(cString: sqlite3_column_text(queryStatement, 1))
                    let flightCode: String = String(cString: sqlite3_column_text(queryStatement, 2))
                    let departAptCode: String = String(cString: sqlite3_column_text(queryStatement, 3))
                    let arriveAptCode: String = String(cString: sqlite3_column_text(queryStatement, 4))
                    
                    // Adding flight data records to the array
                    dataFlight.initWithData(theRow: id, airlineName: airLineName,
                                            theFlightCode: flightCode, departureAirportCode: departAptCode,
                                            arrivalAirportCode: arriveAptCode)
                    
                    flightArr.append(dataFlight)
                    
                    print("Flight Query Result: \(id) | \(airLineName) | \(flightCode) | \(departAptCode) | \(arriveAptCode)")
                }
                sqlite3_finalize(queryStatement)
            }else{
                print("Error in flights prepare")
            }
            sqlite3_close(db)
            
        } else{
            print("unable to open database")
        }
        
    }
    
    
    // Reads the Tweet and Budget data from the database
    func readDataFromDatabase(){
        
        tweetArr.removeAll()
        budgetArr.removeAll()
        
        var db:OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("successfully opened database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            // query for tweets
            var queryString : String = "select * from tweets"
            //query for budget data
            let queryString2: String = "select * from budgets"
            
            if(sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil)) == SQLITE_OK{
                
                while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    
                    // Tweet id and Tweet String
                    let id : Int = Int(sqlite3_column_int(queryStatement,0))
                    let cTweet = sqlite3_column_text(queryStatement, 1)
                    
                    let tweet = String(cString: cTweet!)
                    
                    // Data gets appended into the array
                    let data : TweetData = .init()
                    data.initWithData(theRow: id, theTweet: tweet)
                    tweetArr.append(data)
                    
                    print("query result: ")
                    print("\(id) | \(tweet)")
                }
                sqlite3_finalize(queryStatement)
                
                if(sqlite3_prepare_v2(db, queryString2, -1, &queryStatement, nil)) == SQLITE_OK{
                    
                    while(sqlite3_step(queryStatement) == SQLITE_ROW){
                        
                        // Budget data gets extracted
                        let id : Int = Int(sqlite3_column_int(queryStatement,0))
                        let cDestination = sqlite3_column_text(queryStatement, 1)
                        let transportaton : Double = Double(sqlite3_column_double(queryStatement, 2))
                        let food : Double = Double(sqlite3_column_double(queryStatement, 3))
                        let accommodation : Double = Double(sqlite3_column_double(queryStatement, 4))
                        let other : Double = Double(sqlite3_column_double(queryStatement, 5))
                        let cCurrency = sqlite3_column_text(queryStatement, 6)
                        
                        
                        let destination = String(cString: cDestination!)
                        let currecy = String(cString: cCurrency!)
                        
                        let data : BudgetData = .init()
                        data.initWithData(theRow: id, theDestination: destination, theTransportation: transportaton, theFood: food, theAccommodation: accommodation, theOther: other, TheCurrency: currecy)
                        
                        // Budget data gets appended into an array
                        budgetArr.append(data)
                        
                        print("query result: ")
                        print("\(id) | \(destination) | \(transportaton) | \(food) | \(accommodation) | \(other) | \(currecy)")
                    }
                    sqlite3_finalize(queryStatement)
                }
            } else{
                print("select statement could not be prepared")
            }
        }
    }
    
    // Inserts into Twitter part of the database
    func inserIntoDatabase(tweetInstance : TweetData) -> Bool
    {
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if(sqlite3_open(self.databasePath, &db)) == SQLITE_OK{
            
            var insertStatement : OpaquePointer? = nil
            // Two parameters id and Strig (tweet)
            var insertString : String = "insert into tweets values(NULL, ?)"
            
            
            if sqlite3_prepare_v2(db, insertString, -1, &insertStatement, nil) == SQLITE_OK{
                
                let tweetStr = tweetInstance.tweet! as NSString
                
                sqlite3_bind_text(insertStatement, 1, tweetStr.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inseeteed row \(rowID)")
                }else{
                    
                    print("Couldn't insert row")
                    returnCode = false
                }
                
                sqlite3_finalize(insertStatement)
                
            } else{
                
                print("insert statement could not be prepared")
                returnCode = false
            }
            
            // Closes the database
            sqlite3_close(db)
            
        }else{
            print("*unable to open database")
            returnCode = false
        }
        
        return returnCode
    }
    
    // Add Budget Data in Database
    func insertBudgetIntoDatabase(budget : BudgetData) -> Bool {
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if(sqlite3_open(self.databasePath, &db)) == SQLITE_OK{
            
            var insertStatement : OpaquePointer? = nil
            // SQL query to add data
            let insertString : String = "insert into budgets values(NULL, ?, ?, ?, ?, ?, ?)"
            
            
            if sqlite3_prepare_v2(db, insertString, -1, &insertStatement, nil) == SQLITE_OK{
                
                let destinationStr = budget.destination! as NSString
                let transportation = budget.transportation! as Double
                let food = budget.food! as Double
                let accommodation = budget.accommodation! as Double
                let other = budget.other! as Double
                let currency = budget.currency! as NSString
                
                sqlite3_bind_text(insertStatement, 1, destinationStr.utf8String, -1, nil)
                sqlite3_bind_double(insertStatement, 2, transportation)
                sqlite3_bind_double(insertStatement, 3, food)
                sqlite3_bind_double(insertStatement, 4, accommodation)
                sqlite3_bind_double(insertStatement, 5, other)
                sqlite3_bind_text(insertStatement, 6, currency.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowID)")
                }else{
                    print("Could not insert row")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            }else{
                print("insert statement could not be prepared")
                returnCode = false
            }
            sqlite3_close(db)
        }else{
            print("unable to open database")
            returnCode = false
        }
        
        return returnCode
    }
    
    //Insert Flight search data into DB
    func insertFlightDataIntoDatabase(flight: FlightData) -> Bool {
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        // Starting the DB connection
        if(sqlite3_open(self.databasePath, &db)) == SQLITE_OK{
            
            // sql query with placeholders
            let insertFlightStatement: String = "insert into flights values (NULL, ?, ?, ?, ?);"
            var insertStatement : OpaquePointer? = nil
            
            // preparing the sql query for insert
            if sqlite3_prepare_v2(db,insertFlightStatement,-1, &insertStatement, nil) == SQLITE_OK{
                
                let airlineName = flight.airlineName! as NSString
                let flightCode = flight.flightCode! as NSString
                let departAptCode = flight.departureAirportCode! as NSString
                let arriveAptCode = flight.arrivalAirportCode! as NSString
                
                // replacing the placeholders
                sqlite3_bind_text(insertStatement!, 1, airlineName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement!, 2, flightCode.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement!, 3, departAptCode.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement!, 4, arriveAptCode.utf8String, -1, nil)

                // once insert is complete
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowID)")
                }else{
                    print("Could not insert row")
                    returnCode = false
                }
                // finalizing the sql operation
                sqlite3_finalize(insertStatement)
            }else{
                print("insert statement could not be prepared")
                returnCode = false
            }
            // closing db connection
            sqlite3_close(db)
        }else{
            print("unable to open database")
            returnCode = false
        }
        
        return returnCode
    }
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
