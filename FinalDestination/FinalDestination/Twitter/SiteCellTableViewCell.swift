//
//  SiteCellTableViewCell.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-04-01.
//

import UIKit

/*
 * This class structures the cell.
 */

class SiteCellTableViewCell: UITableViewCell {
    
    // Primary Lable (tweet string)
    let primaryLabel = UILabel()
    
    
    // This defines the structure of the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Primary Lable (tweet) is left aligned, bold, and black font
        primaryLabel.textAlignment = .left
        primaryLabel.font = .boldSystemFont(ofSize: 30)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        //adding the primary lable to the view
        contentView.addSubview(primaryLabel)
    }
    
    // This was required - defines and error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // defines the layout of the cell
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 10, y: 5, width: 460, height: 60)
    }
    
    // required
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // gets activated on tap
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
