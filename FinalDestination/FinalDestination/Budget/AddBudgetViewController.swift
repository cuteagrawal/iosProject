//
//  AddBudgetViewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

class AddBudgetViewController: UIViewController, UITextFieldDelegate {

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var destination : UITextField!
    @IBOutlet var currency : UITextField!
    @IBOutlet var transportation : UITextField!
    @IBOutlet var food : UITextField!
    @IBOutlet var accommodation : UITextField!
    @IBOutlet var other : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addBudgetToDatabse(sender : UIButton){
        let budget : BudgetData = .init()
        budget.initWithData(theRow: 0, theDestination: destination.text!, theTransportation: Double(transportation.text!) ?? 0, theFood: Double(food.text!) ?? 0, theAccommodation: Double(accommodation.text!) ?? 0, theOther: Double(other.text!) ?? 0, TheCurrency: currency.text!)
                
        let returnCode : Bool = mainDelegate.insertBudgetIntoDatabase(budget: budget)
                
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
