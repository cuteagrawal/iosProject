//
//  OldBudgetViewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

class OldBudgetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var budgetTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainDelegate.readDataFromDatabase()
        mainDelegate.viewBudget = nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.budgetArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : BudgetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OldBudgetCell") as? BudgetTableViewCell ?? BudgetTableViewCell(style: .default, reuseIdentifier: "OldBudgetCell")
        
        let rowNum = indexPath.row
        
        tableCell.budgetDestination.text = mainDelegate.budgetArr[rowNum].destination
        tableCell.budgetCurrency.text = mainDelegate.budgetArr[rowNum].currency
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mainDelegate.viewBudget = mainDelegate.budgetArr[indexPath.row]
        performSegue(withIdentifier: "OldBudgetToBudgetView", sender: nil)
    }
    
    @IBAction func unwindToOldBudget(sender : UIStoryboardSegue){

    }

}
