//
//  RecordManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecordManager {
    
    lazy var db = Firestore.firestore()
    
    var myRecipeId: String?
    
    static let shared = RecordManager()
    
    let records = Firestore.firestore().collection(CollectionName.record.rawValue)
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    func createRecord(record: Record, completion: @escaping (Result<String, Error>) -> Void) {
                
        let recordWithId = Record(
            ownerId: userId,
            recordTitle: record.recordTitle,
            recordCategory: record.recordCategory,
            recordNote: record.recordNote,
            focusTime: record.focusTime,
            createdTime: record.createdTime,
            recipeId: RecipeManager.shared.myRecipeId ?? "default")
        
        do {
            
            try records.document().setData(from: recordWithId)
            
            completion(Result.success(recordWithId.recipeId))
                        
        } catch {
            
            print("Fail to create record.")
            
            completion(Result.failure(error))
        }
    }
    
    func fetchRecord(date: Date = Date(), completion: @escaping (Result<[Record], Error>) -> Void) {
        
        let myRecordRef = records
            .whereField("owner_id", isEqualTo: userId)
            .order(by: "created_time", descending: true)
        
        myRecordRef.getDocuments { snapshot, error in
            
            if let error = error {
                
                completion(Result.failure(error))
            }
            
            guard let snapshot = snapshot else { return }
            
            let myRecord = snapshot.documents.compactMap { snapshot in
                
                try? snapshot.data(as: Record.self)
            }
            
            let recordDay = myRecord.filter { record -> Bool in
                
                let recordDate = Date(timeIntervalSince1970: record.createdTime)
                
                let selectedRecord = recordDate.hasSame(.year, as: date)
                    && recordDate.hasSame(.month, as: date)
                    && recordDate.hasSame(.day, as: date)
                
                return selectedRecord
            }
            
            completion(Result.success(recordDay))
        }
    }
}
