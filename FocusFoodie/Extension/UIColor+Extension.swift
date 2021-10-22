//
//  UIColor+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import UIKit

private enum Color: String {

    // swiftlint:disable identifier_name
    case B1

    case B2

    case B3

    case B4

    case B5

    case B6
    
    case B7
    
    case B8
    
    case L1

    case L2

    case L3

    case L4

    case L5

    case L6
    
    case L7

    case L8
}

extension UIColor {

    static let B1 = Color(.B1)

    static let B2 = Color(.B2)
    
    static let B3 = Color(.B3)

    static let B4 = Color(.B4)

    static let B5 = Color(.B5)

    static let B6 = Color(.B6)

    static let B7 = Color(.B7)
    
    static let B8 = Color(.B8)
    
    static let L1 = Color(.L1)
    
    static let L2 = Color(.L2)

    static let L3 = Color(.L3)
    
    static let L4 = Color(.L4)
    
    static let L5 = Color(.L5)

    static let L6 = Color(.L6)

    static let L7 = Color(.L7)

    static let L8 = Color(.L8)
    // swiftlint:enable identifier_name
    
    private static func Color(_ color: Color) -> UIColor? {

        return UIColor(named: color.rawValue)
    }

    static func hexStringToUIColor(hex: String) -> UIColor {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
