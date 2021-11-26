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
import FirebaseFirestoreSwift

typealias GenericCompletion<T: Decodable> = (([T]?, Error?) -> Void)

enum CommunityType {
    
    case friend
    
    case invitation
    
    case block
}

class UserManager {
    
    lazy var db = Firestore.firestore()
    
    static let shared = UserManager()
    
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
    
    func createUserInfo() {
        
        let userRef = db.collection(CollectionName.user.rawValue)
        
        let user = User(displayName: userDisplayName,
                        userId: userId,
                        appleToken: "",
                        userEmail: userEmail,
                        providerId: "Apple",
                        blockList: nil,
                        friendList: nil,
                        recipeList: nil
        )
        
        do {
            
            try userRef.document(user.userId).setData(from: user)
            
        } catch {
            
            print("Fail to create user.")
        }
    }
    
    func fetchUserInfo(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        db.collection(CollectionName.user.rawValue).document(uid).getDocument { document, error in
                
                if let error = error {
                    
                    completion(Result.failure(error))
                }
                
                guard let document = document,
                      document.exists

                else {
                    print(#function)
                    return
                    
                }
                
                do {
                    
                    let user = try? document.data(as: User.self)
                    
                    if let user = user {
                        completion(Result.success(user))
                        
                    }
                    
                } catch {
                    
                    print(error)
                }
                
            }
    }
    
    func addFriend(userId: String,
                   invitorId: String) {
        
        let friendRef = db.collection(CollectionName.user.rawValue).document(userId)
        
        let invitorRef = db.collection(CollectionName.user.rawValue).document(invitorId)
        
        let invitationRef = db.collection(CollectionName.invitation.rawValue)
            .whereField("receiver_id", isEqualTo: userId)
            .whereField("sender_id", isEqualTo: invitorId)
        
        friendRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData([
                    "friend_list" : FieldValue.arrayUnion([invitorId])
                ])
                
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
        
        invitorRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData([
                    "friend_list" : FieldValue.arrayUnion([userId])
                ])
                
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
        
        invitationRef.getDocuments { snapshot, error in
            
            if let snapshot = snapshot {
                
                snapshot.documents.forEach { snapshot in
                    snapshot.reference.delete()
                }
                
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func fetchFriendBlockList(_ type: CommunityType, completion: @escaping (Result<[Any], Error>) -> Void) {
        
        let friendBlockRef = db.collection(CollectionName.user.rawValue).document(userId)
        
        friendBlockRef.getDocument { document, error in
            
            if let error = error {
                completion(Result.failure(error))
            }
            
            guard let document = document else { return }
            
            let object = try? document.data(as: User.self)
            
            switch type {
                
            case .friend:
                let friendList = object?.friendList
                completion(Result.success((friendList ?? []) as [Any]))
                
            case .block:
                let blockList = object?.blockList
                completion(Result.success((blockList ?? []) as [Any]))
                
            case .invitation:
                break
            }
        }
    }
    
    func findFriend(friendId: String) {
        
        let myfriendRef = db.collection(CollectionName.user.rawValue).document(friendId)
        
        myfriendRef.getDocument { document, error in
            
            guard let document = document,
                  document.exists,
                  let myFriend = try? document.data(as: User.self)
                    
            else { return }
        }
    }
}
