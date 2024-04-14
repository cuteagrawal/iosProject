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
    
    var id: Int? // To store ID
    var destination: String? // To store destiantion name
    var transportation: Double? // To store transportation budget
    var food: Double? // To store food budget
    var accommodation : Double? // To store accommodation budget
    var other: Double? // To store other budget
    var currency : String? // To store currecy of destination
    
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
