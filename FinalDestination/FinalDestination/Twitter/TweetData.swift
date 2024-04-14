//
//  TweetData.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-04-01.
//

import UIKit

/*
 * This class acts a Data class for Tweets. Id is the tweet id. Used to update the table.
 * and the tweet is the tweet itself. Could be a simple sentence is "hello".
 */

class TweetData: NSObject {
    
    // id is the tweet id
    var id : Int?
    
    // tweet stores the string of tweet made by the user
    var tweet : String?
    
    // takes 2 parameters id as int and tweets as string saves them in i and n respectively 
    func initWithData(theRow i:Int, theTweet n: String){
        
        id = i
        tweet = n
    }

}
