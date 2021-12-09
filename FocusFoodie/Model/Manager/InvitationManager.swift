//
//  InvitationManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/19.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class InvitationManager {
    
    lazy var db = Firestore.firestore()
    
    static let shared = InvitationManager()
    
    let myId = UserManager.shared.currentUserId
    
    let users = Firestore.firestore().collection(CollectionName.user.rawValue)
    
    let invitations = Firestore.firestore().collection(CollectionName.invitation.rawValue)
    
    func monitorInvitation(completion: @escaping (Result<[Invitation], Error>) -> Void) {
        
        invitations
            .whereField("receiver_id", isEqualTo: myId)
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
    
    func acceptInvitation(userId: String, invitorId: String, completion: @escaping (Result<[Invitation], Error>) -> Void) {
        
        let friendRef = users.document(userId)
        
        let invitorRef = users.document(invitorId)
        
        let invitationRef = invitations
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
