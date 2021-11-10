//
//  UIFont+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import UIKit

enum FontName: String {
    
    case light = "Dongle-Light"
    
    case regular = "Dongle-Regular"
    
    case bold = "Dongle-Bold"
}

extension UIFont {
    
    static func light(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.light.rawValue, size: size)
    }
    
    static func regular(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.regular.rawValue, size: size)
    }
    
    static func bold(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.bold.rawValue, size: size)
    }
    
    private static func font(_ font: FontName, size: CGFloat) -> UIFont? {
        
        return UIFont(name: font.rawValue, size: size)
    }
}
