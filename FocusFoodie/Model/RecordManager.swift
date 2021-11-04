//
//  RecordManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - Collection Name -

enum CollectionName: String {
    
    case user = "User"
    
    case record = "Record"
    
    case request = "Request"
    
    case recipe = "Recipe"
    
    case timer = "Timer"
}

// MARK: - Record -

public struct Record: Codable {
    
    let ownerId: String
    
    let recordTitle: String
    
    let recordCategory: String
    
    let recordNote: String
    
    let focusTime: Int64
    
    let createdTime: Timestamp
    
    let favourite: Bool
    
    let recipeId: String
    
    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case recordTitle = "record_title"
        case recordCategory = "record_category"
        case recordNote = "record_note"
        case focusTime = "focus_time"
        case createdTime = "created_time"
        case favourite
        case recipeId = "recipe_id"
    }
}

// MARK: - Recipe -

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
