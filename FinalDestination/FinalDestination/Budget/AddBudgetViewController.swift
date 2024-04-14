//
//  AddBudgetViewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

/**
 * ViewController for Add Budget page where it will take the values of required fields and add to database
 */
class AddBudgetViewController: UIViewController, UITextFieldDelegate {
    
    // AppDelegate instance
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //IBOulets
    @IBOutlet var destination : UITextField!
    @IBOutlet var currency : UITextField!
    @IBOutlet var transportation : UITextField!
    @IBOutlet var food : UITextField!
    @IBOutlet var accommodation : UITextField!
    @IBOutlet var other : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // This method will fired up when Add Budget button will be clicked and take add to database
    @IBAction func addBudgetToDatabse(sender : UIButton){
        
        // Taking values from the IBOuleted and passing into BudgetData object
        let budget : BudgetData = .init()
        budget.initWithData(theRow: 0, theDestination: destination.text!, theTransportation: Double(transportation.text!) ?? 0, theFood: Double(food.text!) ?? 0, theAccommodation: Double(accommodation.text!) ?? 0, theOther: Double(other.text!) ?? 0, TheCurrency: currency.text!)
         
        // Invoking the insert database methond from AppDelegate
        let returnCode : Bool = mainDelegate.insertBudgetIntoDatabase(budget: budget)
        
        // A Alert Controller after pressing Add Budget button
        if returnCode {
            let alert = UIAlertController(title: "Thank You!", message: "Your Budget Has Been Added", preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.performSegue(withIdentifier: "AddBudgetToOldBudget", sender: self)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            let alertController = UIAlertController(title: "Error!", message: "Budget failed to add", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
    }
    
    // Method to segue back to viewControler after entering value into text box
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
