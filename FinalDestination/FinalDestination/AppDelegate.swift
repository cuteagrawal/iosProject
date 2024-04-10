//
//  AppDelegate.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-03-31.
//

import UIKit
import SQLite3
import MapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var databaseName : String = "FinalDestination.db"
    var databasePath : String = ""
    var tweetArr : [TweetData] = []
    var pointsOfInterest : [MKMapItem] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        
        databasePath = documentsDir.appending("/" + databaseName)
        print("location is: " + databasePath)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    
    
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
    
    
    
    
    func readDataFromDatabase(){
        
        tweetArr.removeAll()
        
        var db:OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("successfully opened database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            var queryString : String = "select * from tweets"
            
            if(sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil)) == SQLITE_OK{
                
                while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    
                    let id : Int = Int(sqlite3_column_int(queryStatement,0))
                    let cTweet = sqlite3_column_text(queryStatement, 1)
                    
                    let tweet = String(cString: cTweet!)
                    
                    let data : TweetData = .init()
                    data.initWithData(theRow: id, theTweet: tweet)
                    tweetArr.append(data)
                    
                    print("query result: ")
                    print("\(id) | \(tweet)")
                }
                sqlite3_finalize(queryStatement)
            } else{
                print("select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else{
            print("unable to open database")
        }
    }
    
    
    
    
    
    func inserIntoDatabase(tweetInstance : TweetData) -> Bool
    {
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if(sqlite3_open(self.databasePath, &db)) == SQLITE_OK{
            
            var insertStatement : OpaquePointer? = nil
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
            
            sqlite3_close(db)
            
        }else{
            print("*unable to open database")
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

