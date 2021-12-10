//
//  UIImage+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

enum ImageAsset: String {
    
    // swiftlint:disable identifier_name
    
    // Logo
    case icon_appLogo
    
    // Tabbar
    case icon_community
    case icon_home
    case icon_record
    
    // Button
    case icon_arrow_left
    case icon_arrow_right
    case icon_check_green
    case icon_cross_green
    case icon_cross_yellow
    case icon_delete
    case icon_notification
    case icon_plus
    case icon_equal
    
    // Category
    case icon_work
    case icon_school
    case icon_baking
    case icon_chores
    case icon_coding
    case icon_fitness
    case icon_gaming
    case icon_shopping
    case icon_relaxing
    
    // Community
    case icon_fingerprint
    case icon_invitation
    case icon_profile
        
    // Ingredient: Bread
    case icon_toast
    case icon_burger_bun
    case icon_baguette
    case icon_croissant
    case icon_flatbread
    
    case icon_toast_color
    
    // Ingredient: Vegetable
    case icon_avocado
    case icon_bell_pepper
    case icon_cucumber
    case icon_lettuce
    case icon_tomato
    case icon_onion
    
    case icon_lettuce_color

    
    // Ingredient: Meat
    case icon_bacon
    case icon_beef
    case icon_falafel
    case icon_shrimp
    case icon_tuna
    case icon_turkey
    
    // Ingredient: Side
    case icon_egg
    case icon_honey
    case icon_mayonnaise
    case icon_ketchup
    case icon_mustard
    case icon_cheese
    
    // Others
    case icon_image
    case icon_timer
    
    case icon_cheese_burger
    case icon_falafel_wrap
    case icon_jerk_chicken

    // swiftlint:enable identifier_name
}

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
