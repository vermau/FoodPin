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
    case BLACK, BLUE, DARKGREY, GREEN, RED, WHITE
    
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
        case .RED:
            return "RGB(red: 246, green: 71, blue: 71)"
        case .WHITE:
            return "RGB(red: 1, green: 1, blue: 1)"
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
        case .RED:
            return "#F64747"
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
        case .RED:
            return "Red"
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
        case .RED:
            return UIColor(red: 0.965, green: 0.278, blue: 0.278, alpha: 1.0)
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
}
