//
//  SiteCell.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit
/**
 * TableViewCell class for the Previous Budget Table
 */
class BudgetTableViewCell: UITableViewCell {
    
    // @IBOulets for the 2 lables in tables
    @IBOutlet var budgetDestination : UILabel! // For Budget Destinaiton lable
    @IBOutlet var budgetCurrency : UILabel! // For Budget Currency lable
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
