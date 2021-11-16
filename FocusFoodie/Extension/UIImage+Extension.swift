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
    case icon_plus
    
    // Button
    case icon_arrow_left
    case icon_check_normal
    case icon_check_selected
    case icon_cross_normal
    case icon_cross_selected
    case icon_heart_normal
    case icon_heart_selected
    case icon_notification
    case icon_notification_filled
    
    // Placeholder
    case icon_loading
    case icon_image
    case icon_timer
    
    // Community
    case icon_accept
    case icon_decline
    case icon_profile
    case icon_fingerprint
    case icon_delete
    
    // Record
    case icon_coding
    
    // Category
    case icon_nap
    
    // Ingredient Gallery
    case icon_knife
    case icon_oil
    
    // Ingredient: Bread
    case icon_toast
    case icon_burger_bun
    case icon_baguette
    case icon_croissant
    case icon_flatbread
    
    // Ingredient: Vegetable
    case icon_avocado
    case icon_bell_pepper
    case icon_cucumber
    case icon_lettuce
    case icon_tomato
    case icon_onion
    
    // Ingredient: Meat
    case icon_bacon
    case icon_chicken
    case icon_falafel
    case icon_shrimp
    case icon_tuna
    case icon_turkey
    
    // Ingredient: Side
    case icon_egg
    case icon_peanutButter
    case icon_honey
    case icon_mayonnaise
    case icon_mustard
    case icon_cheese

    // swiftlint:enable identifier_name
}

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
