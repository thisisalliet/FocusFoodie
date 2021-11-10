//
//  UIImage+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

enum ImageAsset: String {
    
    // swiftlint:disable identifier_name
    // Tabbar
    case icon_community
    case icon_home
    case icon_record
    
    // Button
    case icon_arrow_left
    case icon_check_normal
    case icon_check_selected
    case icon_cross_normal
    case icon_cross_selected
    case icon_heart_normal
    case icon_heart_selected
    
    // Placeholder
    case icon_loading
    
    // Ingredient Gallery
    case icon_knife
    case icon_oil
    
    // Ingredient: Bread
    case icon_toast
    case icon_burger_bun
    case icon_baguette
    case icon_croissant
    
    // Ingredient: Vegetable
    case icon_avocado
    case icon_bell_pepper
    case icon_cucumber
    case icon_lettuce
    case icon_tomato
    case onion
    
    // Ingredient: Meat
    case icon_bacon
    case chicken
    case falafel
    case shrimp
    case tuna
    case turkey
    
    // Ingredient: Side
    case egg
    case peanutButter
    case honey
    case mayonnaise
    case mustard
    case icon_cheese

    // Profile
    case icon_profile
    // swiftlint:enable identifier_name
}

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
