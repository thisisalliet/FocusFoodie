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
    
    let userId: String
    
    let userName: String
    
    let userEmail: String
    
    let providerId: String
    
    let blackList: [String]?
    
    let friendList: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "user_Id"
        
        case userName = "user_name"
        
        case userEmail = "user_email"
        
        case providerId = "provider_id"
        
        case blackList = "black_list"
        
        case friendList = "friend_list"
    }
}
