//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/14/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: StateController {
    
    @IBOutlet weak var ratingButton : UIButton!
    @IBOutlet weak var detailTableView : UITableView!
    @IBOutlet weak var restaurantImageView : UIImageView!
    @IBOutlet weak var gearOptionsView : GearOptionsView!
    
    private var restaurantDetailsDataSource: TableDataSource!
    private var gearOptionsDelegate: GearOptionsDelegate!
    
    private func setupTableViewAppearance() {
        title = modelController.selectedRestaurant.name
        detailTableView.estimatedRowHeight = 36.0
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        // --Change the background color of the DetailTableView
        detailTableView.backgroundColor = UIColor(red: 242.0/255.0, green: 241.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        // --Change the seperator color of the DetailTableView
        detailTableView.separatorColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        
        // --Remove the seperators of the empty rows
        detailTableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableViewAppearance()
        
        restaurantDetailsDataSource = TableDataSource(restaurant: modelController.selectedRestaurant)
        detailTableView.dataSource = restaurantDetailsDataSource
        gearOptionsDelegate = GearOptionsDelegate(view: gearOptionsView, parentViewController: self)
        gearOptionsView.gearOptionsViewDelegate = gearOptionsDelegate

        /*
        -- Using Nil Coalescing Operator here
        -- ?? will return the value of restaurant.rating if it is not nil
        -- otherwise it will return "rating"
        */
        ratingButton.setImage(UIImage(named: modelController.selectedRestaurant.rating ?? "rating"), forState: UIControlState.Normal)

        // --Make the rating button round
        ratingButton.layer.cornerRadius = 20 // --'cuz the Width and Height of the button is 40
        ratingButton.clipsToBounds = true

        // --Load the image in the ImageView
        restaurantImageView.image = UIImage(data: modelController.selectedRestaurant.image!)
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

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    /*override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }*/
    
    @IBAction func close(segue: UIStoryboardSegue) {
        // -- Write code for additional logic that runs upon executing UnwindSegue from the ReviewContoller
        let reviewViewController = segue.sourceViewController as! ReviewViewController
        if let newRating = reviewViewController.rating {
            ratingButton.setImage(UIImage(named: newRating), forState: UIControlState.Normal)
            
            // -- Set the color of the rating button depending upon the actual rating
            switch (newRating) {
                case "dislike": ratingButton.tintColor = COLORS.RED.toUIColor()
                case "good": ratingButton.tintColor = COLORS.BLUE.toUIColor()
                case "great": ratingButton.tintColor = COLORS.SEAGREEN.toUIColor()
            default: break
            }
            
            modelController.selectedRestaurant.rating = newRating
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    private func displayViewControllerOnScreen(vcName: String ) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        weak var destinationVC: UIViewController! = nil
        
        if vcName == "mapView" {
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("mapVC") as! MapViewController
            super.prepareForDestinationViewController(destinationVC)
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } else if vcName == "ratingView" {
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("ratingVC") as! ReviewViewController
            destinationVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            self.presentViewController(destinationVC, animated: true, completion: nil)
        }
    }

    class GearOptionsDelegate: NSObject, GearOptionsViewDelegate {
        weak var gearOptionsView: GearOptionsView! = nil
        weak var parentViewController: RestaurantDetailViewController! = nil
        
        init(view: UIView, parentViewController: UIViewController) {
            self.gearOptionsView = view as! GearOptionsView
            self.parentViewController = parentViewController as! RestaurantDetailViewController
            gearOptionsView.addInitialHideAnimation()
        }
        
        func gearPressed(gear: UIButton) {
            gearOptionsView.addOpenOptionsAnimation()
        }
        
        func locationPressed(location: UIButton) {
            gearOptionsView.addCloseOptionsAnimation()
            parentViewController.displayViewControllerOnScreen("mapView")
        }
        
        func ratingPressed(rating: UIButton) {
            gearOptionsView.addCloseOptionsAnimation()
            parentViewController.displayViewControllerOnScreen("ratingView")
        }
    }
    
    class TableDataSource: NSObject, UITableViewDataSource {
        private var restaurant: Restaurant!
        
        init(restaurant: Restaurant) {
            self.restaurant = restaurant
        }
        
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
                cell.name = restaurant.name
            case 1:
                cell.type = restaurant.type
            case 2:
                cell.location = restaurant.location
            case 3:
                cell.phone = restaurant.phone
            case 4:
                if let hasBeenVisited = restaurant.isVisited?.boolValue {
                    cell.hasBeenVisited = hasBeenVisited
                }
            default:
                break
            }
            return cell
        }
    }
}
