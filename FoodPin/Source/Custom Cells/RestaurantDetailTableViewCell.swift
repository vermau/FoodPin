//
//  RestaurantDetailViewTableCellTableViewCell.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/19/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {

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
    
    internal var name: String? {
        didSet {
            fieldLabel.text = "Name"
            valueLabel.text = (name != nil ? name : nil)
        }
    }
    
    internal var type: String? {
        didSet {
            fieldLabel.text = "Type"
            valueLabel.text = (type != nil ? type : nil)
        }
    }
    
    internal var location: String? {
        didSet {
            fieldLabel.text = "Location"
            valueLabel.text = (location != nil ? location : nil)
        }
    }
    
    internal var phone: String? {
        didSet {
            fieldLabel.text = "Phone"
            valueLabel.text = (phone != nil ? phone : nil)
        }
    }
    
    internal var hasBeenVisited = false {
        didSet{
            fieldLabel.text = "Been Here"
            valueLabel.text = (hasBeenVisited ? "Yes, I have been here" : "No, I haven't been here")
        }
    }
}
