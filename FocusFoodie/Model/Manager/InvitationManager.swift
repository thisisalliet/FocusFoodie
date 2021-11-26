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
    
    let myId = UserManager.shared.userId
    
    func monitorInvitation(uid: String, completion: @escaping (Result<[Invitation], Error>) -> Void) {
        
        db.collection(CollectionName.invitation.rawValue)
            .whereField("receiver_id",isEqualTo: myId)
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
}
