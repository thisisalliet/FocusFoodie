//
//  Request.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import Foundation

public struct Invitation: Codable {
    
    let receiverId: String
    
    let senderId: String
    
    enum CodingKeys: String, CodingKey {
        
        case receiverId = "receiver_id"
        
        case senderId = "sender_id"
    }
}
