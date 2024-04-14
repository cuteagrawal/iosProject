//
//  OldBudgetViewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

/**
 * ViewController which will show the previoud Budgets in table form
 */
class OldBudgetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // AppDelegate instance to get the viewBudget property
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var budgetTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling read database methond in AppDelegate and assigning null to viewBudget
        mainDelegate.readDataFromDatabase()
        mainDelegate.viewBudget = nil
    }
    
    // Method which will return the row numbers for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.budgetArr.count
    }
    
    // Method to set height of table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Method to formate cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : BudgetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OldBudgetCell") as? BudgetTableViewCell ?? BudgetTableViewCell(style: .default, reuseIdentifier: "OldBudgetCell")
        
        let rowNum = indexPath.row
        
        // Assigning Destiantion value to Budget Destination lable
        tableCell.budgetDestination.text = mainDelegate.budgetArr[rowNum].destination
        
        // Assigning Currency value to Budget Currency lable
        tableCell.budgetCurrency.text = mainDelegate.budgetArr[rowNum].currency
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    // Method to allowing to edit each rows in table
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Method will invoke when rows of table is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mainDelegate.viewBudget = mainDelegate.budgetArr[indexPath.row]
        performSegue(withIdentifier: "OldBudgetToBudgetView", sender: nil)
    }
    
    @IBAction func unwindToOldBudget(sender : UIStoryboardSegue){

    }

}
