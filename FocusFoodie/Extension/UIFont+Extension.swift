//
//  UIFont+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import UIKit

enum FontName: String {
    
    case light = "RobotoMono-Light"
    
    case regular = "RobotoMono-Regular"
    
    case medium = "RobotoMono-Medium"
    
    case semiBold = "RobotoMono-SeniBold"
    
    case bold = "RobotoMono-Bold"
}

extension UIFont {
    
    static func light(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.light.rawValue, size: size)
    }
    
    static func regular(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.regular.rawValue, size: size)
    }
    
    static func medium(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.medium.rawValue, size: size)
    }
    
    static func semiBold(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.semiBold.rawValue, size: size)
    }
    
    static func bold(size: CGFloat) -> UIFont? {
        
        return UIFont(name: FontName.bold.rawValue, size: size)
    }
    
    private static func font(_ font: FontName, size: CGFloat) -> UIFont? {
        
        return UIFont(name: font.rawValue, size: size)
    }
}
