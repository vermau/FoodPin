//
//  Types.swift
//  FoodPin
//
//  Created by Ujjwal Verma on 2/3/16.
//  Copyright © 2016 Intellisoft. All rights reserved.
//

import Foundation
import UIKit

/*
    -------------------------------------------------
                ENUMS DEFINED
    -------------------------------------------------
*/

enum COLORS {
    case BLACK, BLUE, DARKGREY, GREEN, PINK, RED, TOMATO, WHITE
    
    internal func RBGValue() -> String {
        switch self {
        case .BLACK:
            return "RGB(red: 0, green: 0, blue: 0)"
        case .BLUE:
            return "RGB(red: 0, green: 143, blue: 255)"
        case .DARKGREY:
            return "RGB(red: 85, green: 85, blue: 85)"
        case .GREEN:
            return "RGB(red: 86, green: 206, blue: 27)"
		case .PINK:
			return "RGB(red: 246, green: 135, blue: 137)"
        case .RED:
            return "RGB(red: 246, green: 71, blue: 71)"
		case .TOMATO:
			return "RGB(red: 246, green: 71, blue: 71)"
        case .WHITE:
            return "RGB(red: 229, green: 94, blue: 67)"
        }
    }

    internal func HexValue() -> String {
        switch self {
        case .BLACK:
            return "#000000"
        case .BLUE:
            return "#008FFF"
        case .DARKGREY:
            return "#686868"
        case .GREEN:
            return "#56CE1B"
		case .PINK:
			return "#F68789"
        case .RED:
            return "#F64747"
		case .TOMATO:
			return "#E55E43"
        case .WHITE:
            return "#FFFFFF"
        }
    }
    
    internal func toString() -> String {
        switch self {
        case .BLACK:
            return "Black"
        case .BLUE:
            return "Blue"
        case .DARKGREY:
            return "DarkGrey"
        case .GREEN:
            return "Green"
		case .PINK:
			return "Pink"
        case .RED:
            return "Red"
		case .TOMATO:
			return "Tomato"
        case .WHITE:
            return "White"
        }
    }

    internal func toUIColor() -> UIColor {
        switch self {
        case .BLACK:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .BLUE:
            return UIColor(red:0.0,  green:0.463,  blue:1.0, alpha:1.0)
        case .DARKGREY:
            return UIColor(red: 0.408, green: 0.408, blue: 0.408, alpha: 1.0)
        case .GREEN:
            return UIColor(red: 0.314, green: 0.816, blue: 0.0, alpha: 1.0)
		case .PINK:
			return UIColor(red: 0.949, green: 0.454, blue: 0.466, alpha: 1.0)
        case .RED:
            return UIColor(red: 0.965, green: 0.278, blue: 0.278, alpha: 1.0)
		case .TOMATO:
			return UIColor(red: 0.898, green: 0.369, blue: 0.263, alpha: 1.0)
        case .WHITE:
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

/*
    -------------------------------------------------
                STRUCTS DEFINED
    -------------------------------------------------
*/

struct HELPER {
    struct CONVERT {
        
        // -- Returns a UIColor object
        static func RGBtoUICOLOR (red: Int, green: Int, blue: Int) -> UIColor {
            return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1)/255.0)
        }
        
        // -- Returns a TUPLE containing RED, GREEN and BLUE components of a color
        static func UICOLORtoRGB (color: UIColor) -> (red: Int, green: Int, blue: Int) {
            let components = CGColorGetComponents(color.CGColor) // -- Returns a array containing the r,g,b values
            return (red: Int(components[0] * 255.0), green: Int(components[1] * 255.0), blue: Int(components[2] * 255.0))
        }
    }
	
	struct AUTOLAYOUT {
		
		// -- Sets AutoLayout Constraints for a View
		static func setFrameAutoLayoutForView(aView: UIView!, top: CGFloat?, var bottom: CGFloat?, leading: CGFloat?, var trailing: CGFloat?, centreViewHorizontallyAndVertically: Bool) {
			var topConstraint = NSLayoutConstraint(), bottomConstraint = NSLayoutConstraint(), leadingConstraint = NSLayoutConstraint(), trailingConstraint = NSLayoutConstraint()
			//var centreXConstraint = NSLayoutConstraint(), centreYConstraint = NSLayoutConstraint()
			
			if centreViewHorizontallyAndVertically == true {
				bottom = top
				trailing = leading
				
				let centreXConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
				
				let centreYConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
				
				// -- Activate the CentraX and CentreY Autolayout Constraints
				centreXConstraint.active = true
				centreYConstraint.active = true
			}
			
			// -- Setup the Top, Bottom, Leading and Trailing Autolayout Constraints for the View
			if top == nil {
				topConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
			} else {
				topConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: top!)
			}
			if bottom == nil {
				bottomConstraint = NSLayoutConstraint(item: aView.superview!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: aView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
			} else {
				bottomConstraint = NSLayoutConstraint(item: aView.superview!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: aView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: bottom!)
			}
			if leading == nil {
				leadingConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
			} else {
				leadingConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: aView.superview!, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: leading!)
			}
			if trailing == nil {
				trailingConstraint = NSLayoutConstraint(item: aView.superview!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: aView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
			} else {
				trailingConstraint = NSLayoutConstraint(item: aView.superview!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: aView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: trailing!)
			}
			
			// -- Activate the Top, Bottom, Leading and Trailing Autolayout Constraints
			topConstraint.active = true
			bottomConstraint.active = true
			leadingConstraint.active = true
			trailingConstraint.active = true
		}
	}
}
