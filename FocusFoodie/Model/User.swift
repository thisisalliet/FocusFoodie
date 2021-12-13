//
//  User.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import Firebase
import Foundation
import FirebaseFirestoreSwift

public struct User: Codable {
    
    let displayName: String?
    
    let userId: String // Firbase Auto-ID
    
    let appleToken: String
    
    let userEmail: String?
    
    let providerId: String
    
    let blockList: [String]?
    
    let friendList: [String]?

    let recipeList: [String]?

    enum CodingKeys: String, CodingKey {
        
        case userId = "user_id"
        
        case appleToken = "apple_token"
        
        case displayName = "display_name"
        
        case userEmail = "user_email"
        
        case providerId = "provider_id"
        
        case blockList = "block_list"
        
        case friendList = "friend_list"
        
        case recipeList = "recipe_list"

    }
}
