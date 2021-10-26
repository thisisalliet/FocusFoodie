//
//  UIImage+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

enum ImageAsset: String {
    
    // swiftlint:disable identifier_name
    //Tabbar
    case icon_community
    case icon_timer
    case icon_category
    
    // Back button
    case icon_arrow_left

    // Like button
    case icon_heart_normal
    case icon_heart_selected
    
    // Placeholder
    case icon_loading
    
    // Timer
    case icon_knife
    case icon_oil

    // Profile
    case icon_profile
    // swiftlint:enable identifier_name
}


extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
