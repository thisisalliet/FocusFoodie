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
    
    case T1
    
    case T2
        
    case Y1
    
    case Y2
    
    case G1
    
    case G2
    
    case G3
}

extension UIColor {
    
    static let T1 = color(.T1)
    
    static let T2 = color(.T2)
        
    static let G1 = color(.G1)

    static let G2 = color(.G2)

    static let G3 = color(.G3)

    static let Y1 = color(.Y1)
    
    static let Y2 = color(.Y2)

    // swiftlint:enable identifier_name
    
    private static func color(_ color: Color) -> UIColor? {

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
