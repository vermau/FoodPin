//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/14/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet weak var restaurantImageView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblLocation : UILabel!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the image in the ImageView
        lblName.text = restaurant.name
        lblLocation.text = restaurant.location
        restaurantImageView.image = UIImage(named: restaurant.image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
