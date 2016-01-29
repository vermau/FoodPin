//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 1/25/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView : UIImageView!
    @IBOutlet weak var ratingStackView : UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- Creating the blur effect on the backgroundImageView
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // -- Set the initial size of the ratingStackView to start the animation
        // -- Initiating the SCALING TRANSFORMATION for ratingStackView
        let scale = CGAffineTransformMakeScale(0.0, 0.0)

        // -- Set the initial size of the ratingStackView to start the animation
        // -- Initiating the TRANSLATING TRANSFORMATION for ratingStackView
        let translate = CGAffineTransformMakeTranslation(0.0, 500.0)

        // -- Combining two transformations for the ratingStackView
        ratingStackView.transform = CGAffineTransformConcat(scale, translate)
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        // -- Do the animation of ratingStackView here
        // -- CGAffineTransformIdentity is a constant that sets the final state of the animation equal to the original state of the object being animated
        
        // -- SIMPLE animation with Scaling factor
        /*
        UIView.animateWithDuration(0.6, delay: 0.0, options: [], animations: {
                self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
        */
        
        // -- SPRING animation with Scaling factor
        UIView.animateWithDuration(0.9, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: [], animations: {
                self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
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
