//
//  FirebaseManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

typealias GenericCompletion<T: Decodable> = (([T]?, Error?) -> Void)

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
}
