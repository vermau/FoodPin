//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 16/10/2015.
//  Copyright © 2015 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
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
            lblName.text = (name != nil ? name : nil)
        }
    }

    internal var location: String? {
        didSet {
            lblLocation.text = (location != nil ? location : nil)
        }
    }

    internal var type: String? {
        didSet {
            lblType.text = (type != nil ? type : nil)
        }
    }
}
