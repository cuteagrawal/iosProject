//
//  BudgetData.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

/**
 *  NSObject to  hold the data of Budgets
 */
class BudgetData: NSObject {
    
    var id: Int?
    var destination: String?
    var transportation: Double?
    var food: Double?
    var accommodation : Double?
    var other: Double?
    var currency : String?
    
    // Constructor
    func initWithData(theRow i:Int, theDestination n:String, theTransportation e:Double, theFood a:Double, theAccommodation z:Double, theOther g:Double, TheCurrency av:String){
        id = i
        destination = n
        transportation = e
        food = a
        accommodation = z
        other = g
        currency = av
    }
}
