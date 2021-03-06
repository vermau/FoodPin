//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 2/1/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit
import CoreData
// ----------------------------------------------------------------------------------------------------------------------
// -- UITableView Protocol Methods
class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // ----------------------------------------------------------------------------------------------------------------------
    // -- Private and Internal Properties
    
	private var alertView: UIAlertController!
	private var isVisited = false
    internal var modelController: ModelController!
	internal var newRestaurant: Restaurant!

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
        title = "New Restaurant"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // --Saves New Restaurant details to database
	private func saveNewRecord() {
		if let managedObjectContext = modelController?.managedObjectContext {
			newRestaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
			newRestaurant.name = nameTextField.text!
			newRestaurant.type = typeTextField.text!
			newRestaurant.location = locationTextField.text!
			newRestaurant.phone = phoneTextField.text!
			newRestaurant.isVisited = isVisited
			newRestaurant.image = UIImagePNGRepresentation(imageView.image!)
			newRestaurant.rating = nil
            
            modelController.saveContext()
		}
	}
	
    // ----------------------------------------------------------------------------------------------------------------------
    // -- IBAction Methods
    
    @IBAction func saveNewRestaurantDetails(sender: UIButton) {
		
		// -- Data entry validation
        if (nameTextField.text! == "" || typeTextField.text! == "" || locationTextField.text! == "") {
			alertView = UIAlertController(title: "Warning", message: "Fields with '*' are Mandatory", preferredStyle: .Alert) // -- Auto Dismissing UIAlertController

			// -- Immediately present the UIAlertController as soon as the If conditon is met on pressing the Save button
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(self.alertView, animated: true, completion: nil)
            })
            
            /*
            -- NSTimer For auto dismissing the UIAlertController
            -- It calls the "dismissAlertController func after 2 seconds of display
            */
            _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.dismissAlertController), userInfo: nil, repeats: false)
        } else {
            self.saveNewRecord()
            performSegueWithIdentifier("unwindToHomeScreen", sender: sender)
        }
    }
	
    @IBAction func isVisitedSelection(sender: UIButton) {
        switch (sender.tag) {
        case 1: // -- YES Button clicked
            yesButton.backgroundColor! = COLORS.BLUE.toUIColor()
            noButton.backgroundColor! = COLORS.DARKGREY.toUIColor()
            isVisited = true
        case 0: // -- NO Button clicked
            noButton.backgroundColor! = COLORS.RED.toUIColor()
            yesButton.backgroundColor! = COLORS.DARKGREY.toUIColor()
            isVisited = false
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
	
    // ----------------------------------------------------------------------------------------------------------------------
    // -- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
