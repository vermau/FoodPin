//
//  RestaurantDetailViewTableCellTableViewCell.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/19/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantDetailViewTableCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
