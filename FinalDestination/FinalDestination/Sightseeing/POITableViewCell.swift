//
//  POITableViewCell.swift
//  FinalDestination
//
//  Created by Jacob Rotundo on 2024-04-09.
//

import UIKit

class POITableViewCell: UITableViewCell {

    //The name of the Point of Interest
    @IBOutlet var locationName : UILabel!
    
    //The type of the Point of Interest
    @IBOutlet var locationType : UILabel!
    
    //The phone number of the Point of Interest
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
