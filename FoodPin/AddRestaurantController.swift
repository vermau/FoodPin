//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 2/1/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Private Properties
    
    private var newRestaurant = Restaurant() // -- Default initialiser used
    private let alertView = UIAlertController(title: "Warning", message: "All fields are mandatory", preferredStyle: .Alert) // -- Auto Dismissing UIAlertController

    // ----------------------------------------------------------------------------------------------------------------------
    // -- IBOutlet Properties
    
    @IBOutlet private weak var imageView : UIImageView!
    @IBOutlet private weak var nameTextField : UITextField!
    @IBOutlet private weak var typeTextField : UITextField!
    @IBOutlet private weak var phoneTextField : UITextField!
    @IBOutlet private weak var locationTextField : UITextField!
    @IBOutlet private weak var noButton : UIButton!
    @IBOutlet private weak var yesButton : UIButton!
    
    // ----------------------------------------------------------------------------------------------------------------------
    // -- Standard Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // ----------------------------------------------------------------------------------------------------------------------
    // -- IBAction Methods
    
    @IBAction func saveNewRestaurantDetails(sender: UIButton) {
        if (nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" || phoneTextField.text == "") {
            
            // -- Immediately present the UIAlertController as soon as the If conditon is met on pressing the Save button
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(self.alertView, animated: true, completion: nil)
            })
            
            /*
            -- NSTimer For auto dismissing the UIAlertController
            -- It calls the "dismissAlertController func after 2 seconds of display
            */
            _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("dismissAlertController"), userInfo: nil, repeats: false)
        } else {
            newRestaurant.name = nameTextField.text!
            newRestaurant.type = typeTextField.text!
            newRestaurant.location = locationTextField.text!
            newRestaurant.phone = phoneTextField.text!
            
            performSegueWithIdentifier("unwindToHomeScreen", sender: sender)
        }
    }
    
    @IBAction func isVisitedSelection(sender: UIButton) {
        switch (sender.tag) {
        case 1: // -- YES Button clicked
            yesButton.backgroundColor! = COLORS.BLUE.toUIColor()
            noButton.backgroundColor! = COLORS.DARKGREY.toUIColor()
            newRestaurant.isVisited = true
        case 0: // -- NO Button clicked
            noButton.backgroundColor! = COLORS.RED.toUIColor()
            yesButton.backgroundColor! = COLORS.DARKGREY.toUIColor()
            newRestaurant.isVisited = false
        default: break
        }
    }

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Selector Methods
    
    internal func dismissAlertController() {
        // -- Dismiss the UIAlertcontroller
        alertView.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ----------------------------------------------------------------------------------------------------------------------
    // -- UIImagePickerController Protocol Methods
    
    // -- This method is only called after an image is selected from the photolibrary in the UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let selectedImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			imageView.image = selectedImage
			imageView.contentMode = UIViewContentMode.ScaleAspectFill
			imageView.clipsToBounds = true
			
			HELPER.AUTOLAYOUT.setFrameAutoLayoutForView(imageView, top: nil, bottom: nil, leading: nil, trailing: nil, centreViewHorizontallyAndVertically: true)
		}
		
        // -- Dismisses the current ViewController ( in this case the UIImagePickerController )
        dismissViewControllerAnimated(true, completion: nil)
    }

    // ----------------------------------------------------------------------------------------------------------------------
    // -- UITableView Protocol Methods

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
	
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
