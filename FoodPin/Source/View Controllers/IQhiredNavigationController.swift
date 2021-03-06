//
//  iqhiredNavigationController.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 2/9/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import UIKit

class IQhiredNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationBar.translucent = false
		self.navigationBar.tintColor = COLORS.BLACK.toUIColor()
		
		// -- Create the Gradient Background of the NavigationBar by setting the Gradient Image as it's background
		self.navigationBar.setBackgroundImage(imageForGradientBackground(), forBarMetrics: UIBarMetrics.Default)
		
		if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
			let fontDictionary = [NSForegroundColorAttributeName: COLORS.BLACK.toUIColor(), NSFontAttributeName: barFont]
			self.navigationBar.titleTextAttributes = fontDictionary
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	private func imageForGradientBackground() -> UIImage {
		
		// -- Create a Frame equal to the size of the Navigation Bar
		var navigationBarFrame = self.navigationBar.bounds
		
		// -- Taking into account the Status Bar at the top
		navigationBarFrame.size.height += 20
		
		// -- Create a Gradient Layer equal to the size of the NavigationBarFrame
		let gradientLayer = CAGradientLayer.gradientLayerForBounds(navigationBarFrame)
		
		/*	-- Create an Image out of the Gradient Layer
			-- For NavigationBar the Gradient background can only be set by using a background image with Gradient
		*/
		UIGraphicsBeginImageContext(gradientLayer.bounds.size)
		gradientLayer.renderInContext(UIGraphicsGetCurrentContext()!)
		
		let gradientBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return gradientBackgroundImage
	}
}
