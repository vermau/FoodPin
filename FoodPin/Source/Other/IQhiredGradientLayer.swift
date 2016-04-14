//
//  iqhiredGradientLayer.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 2/9/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

extension CAGradientLayer {
	class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
		let layer = CAGradientLayer()
		
		layer.frame = bounds
		layer.colors = [COLORS.RED.toUIColor().CGColor, COLORS.WHITE.toUIColor().CGColor]
		
		return layer
	}
}
