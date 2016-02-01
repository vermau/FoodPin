//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/14/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var restaurantImageView : UIImageView!
    @IBOutlet weak var detailTableView : UITableView!
    @IBOutlet weak var ratingButton : UIButton!
    @IBOutlet weak var mapButton : UIButton!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // --Set the title of the DetailTableViewController
        title = restaurant.name
        
        /*
        -- Using Nil Coalescing Operator here
        -- ?? will return the value of restaurant.rating if it is not nil
        -- otherwise it will return "rating"
        */
        ratingButton.setImage(UIImage(named: restaurant.rating ?? "rating"), forState: UIControlState.Normal)

        // --Make the rating button round
        ratingButton.layer.cornerRadius = 20 // --'cuz the Width and Height of the button is 40
        ratingButton.clipsToBounds = true

        // --Load the image in the ImageView
        restaurantImageView.image = UIImage(named: restaurant.image)
        
        detailTableView.estimatedRowHeight = 36.0
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        // --Change the background color of the DetailTableView
        detailTableView.backgroundColor = UIColor(red: 242.0/255.0, green: 241.0/255.0, blue: 239.0/255.0, alpha: 1.0)

        // --Change the seperator color of the DetailTableView
        detailTableView.separatorColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)

        // --Remove the seperators of the empty rows
        detailTableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
            -- If the NavigationBar is set to hide on scroll down in the Main ViewController
            -- it will remain hidden in the Destination ViewController as well even if hidesBarsOnSwipe property of NavigationController is set to FALSE
            -- We have to specifically tell the app to show the NavigationBar in the Destination ViewController
        */
        navigationController?.hidesBarsOnSwipe = false
        // --Specific instruction to the app to show the NavigationBar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    /*
                    ---------------------------------------
                        Mark: - TableView data population
                    ---------------------------------------
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        // --Makes the background of the cell filled with content as transparent background
        // --so that the background color of the DetailTableView can be seen
        cell.backgroundColor = UIColor.clearColor()
        
        // --Configure the custom cell with required values
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been Here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes I have been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        return cell
    }


    /*
                    ---------------------------------------
                        Mark: - StatusBar customization
                    ---------------------------------------
    */
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    /*override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }*/
    
    /*
                    ---------------------------------------
                        MARK: - Navigation
                    ---------------------------------------
    */

    @IBAction func close(segue: UIStoryboardSegue) {
        // -- Write code for additional logic
        // -- that runs upon executing UnwindSegue
        // -- from the ReviewContoller
        
        let reviewViewController = segue.sourceViewController as! ReviewViewController
        if let newRating = reviewViewController.rating {
            ratingButton.setImage(UIImage(named: newRating), forState: UIControlState.Normal)
            restaurant.rating = newRating
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destinationViewController as! MapViewController
            destinationViewController.restaurant = restaurant
        }
    }
}
