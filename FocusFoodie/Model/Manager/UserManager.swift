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
                        friendList: nil)
        
        do {
            
            try userRef.document(user.userId).setData(from: user)
            
        } catch {
            
            print("Fail to create user.")
        }
    }
    
    func fetchUserInfo(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        db.collection(CollectionName.user.rawValue).document(uid)
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
    
    func monitorInvitation(uid: String, completion: @escaping (Result<[Invitation], Error>) -> Void) {
        
        db.collection(CollectionName.invitation.rawValue)
            .whereField("receiver_id",isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                
                guard let snapshot = snapshot else { return }
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    var allInvitations = [Invitation]()
                    
                    for document in snapshot.documents {
                        
                        do {
                            
                            if let invite = try document.data(as: Invitation.self, decoder: Firestore.Decoder()) {
                                
                                allInvitations.append(invite)
                            }
                            
                        } catch {
                            
                            completion(.failure(error))
                        }
                    }
                    
                    completion(.success(allInvitations))
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
}
