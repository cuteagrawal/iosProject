//
//  TweetData.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-04-01.
//

import UIKit

class TweetData: NSObject {
    
    var id : Int?
    var tweet : String?
    
    
    func initWithData(theRow i:Int, theTweet n: String){
        
        id = i
        tweet = n
    }

}
