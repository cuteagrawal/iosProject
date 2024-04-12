//
//  SiteCell.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    
    @IBOutlet var budgetDestination : UILabel!
    @IBOutlet var budgetCurrency : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
