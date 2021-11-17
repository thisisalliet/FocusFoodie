//
//  RecordManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Firebase
import Foundation
import FirebaseFirestoreSwift

public struct Record: Codable {
    
    let ownerId: String
    
    let recordTitle: String?
    
    let recordCategory: String?
    
    let recordNote: String?
    
    let focusTime: Int
    
    let createdTime: Timestamp
    
    let favourite: Bool?
    
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
