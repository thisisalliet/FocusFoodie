//
//  ProfileItem.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit
import Foundation

protocol ProfileItem {

    var image: UIImage? { get }
    
    var status: String? { get }

    var category: String { get }
}

//enum InfoItem: ProfileItem {
//    
//    
//}
