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

class UserManager {
    
    lazy var db = Firestore.firestore()
    
    static let shared = UserManager()
    
    private init() {}
    
    let users = Firestore.firestore().collection(CollectionName.user.rawValue)
    
    let currentUserId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    let currentUserName: String = {
        
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
        
        let user = User(displayName: currentUserName,
                        userId: currentUserId,
                        appleToken: "",
                        userEmail: userEmail,
                        providerId: "Apple",
                        blockList: nil,
                        friendList: nil,
                        recipeList: nil
        )
        
        do {
            
            try users.document(user.userId).setData(from: user)
            
        } catch {
            
            print("Fail to create user.")
        }
    }
    
    func monitorUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        
        users.document(currentUserId).addSnapshotListener { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            var userInfo = User(displayName: "",
                                userId: "",
                                appleToken: "",
                                userEmail: "",
                                providerId: "",
                                blockList: [],
                                friendList: [],
                                recipeList: [])
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                //                if !snapshot.documentChanges.isEmpty {
                
                //                    snapshot.documentChanges.forEach { (documentChange) in
                
                //                    snapshot.documents.forEach { document in
                
                do {
                    
                    if let user = try snapshot.data(as: User.self, decoder: Firestore.Decoder()) {
                        
                        userInfo = user
                    }
                    
                } catch {
                    
                    completion(.failure(error))
                }
                //                    }
                
                //                    }
                //                }
                
                completion(.success(userInfo))
            }
        }
    }
    
    func fetchUserInfo(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        users.document(uid).getDocument { document, error in
            
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
    
    
    func removeFriend(userId: String,
                      completion: @escaping (Result<String, Error>) -> Void) {
        
        let myRef = users.document(currentUserId)
        
        let friendRef  = users.document(userId)
        
        myRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData(["friend_list" : FieldValue.arrayRemove([userId])])
                
                document.reference.updateData(["block_list" : FieldValue.arrayUnion([userId])])
                
                completion(.success("Friend ID remove from my friend list"))
                
            } else {
                
                if let error = error {
                    
                    completion(.failure(error))
                }
            }
        }
        
        friendRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData(["friend_list" : FieldValue.arrayRemove([self.currentUserId])])
                
                document.reference.updateData(["block_list" : FieldValue.arrayUnion([self.currentUserId])])
                
                completion(.success("My ID remove from friend's friend list"))
                
            } else {
                
                if let error = error {
                    
                    completion(.failure(error))
                }
            }
        }
    }
    
    func removeBlock(userId: String,
                     completion: @escaping (Result<String, Error>) -> Void) {
        
        let myRef = users.document(currentUserId)
        
        let friendRef  = users.document(userId)
        
        myRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData(["block_list" : FieldValue.arrayRemove([userId])])
                
                document.reference.updateData(["friend_list" : FieldValue.arrayUnion([userId])])
                
                completion(.success("Friend ID remove from my block list and add to friend list"))
                
            } else {
                
                if let error = error {
                    
                    completion(.failure(error))
                }
            }
        }
        
        friendRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData(["block_list" : FieldValue.arrayRemove([self.currentUserId])])
                
                document.reference.updateData(["friend_list" : FieldValue.arrayUnion([self.currentUserId])])
                
                completion(.success("My ID added to friend's list"))
                
            } else {
                
                if let error = error {
                    
                    completion(.failure(error))
                }
            }
        }
    }
    
    //    func fetchFriendBlockList(_ type: CommunityType, completion: @escaping (Result<[Any], Error>) -> Void) {
    
    //        friendBlockRef.getDocument { document, error in
    //
    //            if let error = error {
    //
    //                completion(Result.failure(error))
    //            }
    //
    //            guard let document = document else { return }
    //
    //            let object = try? document.data(as: User.self)
    //
    //            switch type {
    //
    //            case .friend:
    //                let friendList = object?.friendList
    //                completion(Result.success((friendList ?? []) as [Any]))
    //
    //            case .block:
    //                let blockList = object?.blockList
    //                completion(Result.success((blockList ?? []) as [Any]))
    //
    //            case .invitation:
    //                break
    //            }
    //        }
    //    }
    
    //    func findFriend(friendId: String) {
    //
    //        let myfriendRef = db.collection(CollectionName.user.rawValue).document(friendId)
    //
    //        myfriendRef.getDocument { document, error in
    //
    //            guard let document = document,
    //                  document.exists,
    //                  let myFriend = try? document.data(as: User.self)
    //
    //            else { return }
    //        }
    //    }
}
