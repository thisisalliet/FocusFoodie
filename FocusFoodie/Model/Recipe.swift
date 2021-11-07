//
//  Recipe.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import UIKit
import Foundation
import FirebaseFirestore

public struct Recipe: Codable {
    
    let bread: String
    
    let vegetable: String
    
    let meat: String
    
    let side: String
    
    let focusTime: Int64
    
    let recipeId: String
    
    enum CodingKeys: String, CodingKey {
        case bread
        case vegetable
        case meat
        case side
        case focusTime = "focus_time"
        case recipeId = "recipe_id"
    }
}
