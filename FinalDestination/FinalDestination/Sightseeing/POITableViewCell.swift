//
//  POITableViewCell.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit

class POITableViewCell: UITableViewCell {

    @IBOutlet var locationName : UILabel!
    @IBOutlet var locationType : UILabel!
    @IBOutlet var locationPhoneNumber : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
