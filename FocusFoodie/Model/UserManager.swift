//
//  UserManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManager {
    
    static let shared = UserManager()
    
    lazy var db = Firestore.firestore()
    
    let user = Auth.auth().currentUser
    
    private init() {}
    
    let userId: String = {
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    let userDisplayName: String = {
        
        if let user = Auth.auth().currentUser,
           let userName = user.displayName {
            
            return userName
            
        } else {
            
            return "User"
        }
    }()
    
    let userEmail: String = {
        
        if let user = Auth.auth().currentUser,
           let userEmail = user.email {
            
            return userEmail
            
        } else {
            
            return "User Email"
        }
    }()
    
    // create
    func createUserInfo() {
        let user = User(displayName: userDisplayName,
                        userId: userId,
                        appleToken: "",
                        userEmail: userEmail,
                        providerId: "Apple",
                        blockList: nil,
                        friendList: nil
        )
        
        let userRef = db.collection(CollectionName.user.rawValue)
        
        do {
            
            try userRef.document(user.userId).setData(from: user)
            
        } catch {
            
            print("Fail to create user")
        }
    }
    
    // read
    func fetchUserInfo(uesrId: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let userRef = db.collection(CollectionName.user.rawValue)
        
        let uid = user
        
        userRef.whereField("user_id", isEqualTo: uid)
        
        userRef.document(userId)
            .getDocument { document, error in
            
            if let error = error {
                
                completion(Result.failure(error))
            }
            
            guard let document = document,
                  document.exists,
                  let user = try? document.data(as: User.self)
                    
            else { return }
            
            completion(Result.success(user))
        }
    }
}
