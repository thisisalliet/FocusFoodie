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
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    func createRecord(record: Record) {
        
        let recordRef = db.collection(CollectionName.record.rawValue).document()
        
        let record = Record(
            ownerId: userId,
            recordTitle: record.recordTitle,
            recordCategory: record.recordCategory,
            recordNote: record.recordNote,
            focusTime: record.focusTime,
            createdTime: record.createdTime,
            recipeId: RecipeManager.shared.myRecipe ?? "default")
        
        do {
            
            try recordRef.setData(from: record)
            
        } catch {
            
            print("Fail to create record.")
        }
    }
    
    func fetchRecord(date: Date, completion: @escaping (Result<[Record], Error>) -> Void) {
        
        let myRecordRef = db.collection(CollectionName.record.rawValue)
            .whereField("owner_id", isEqualTo: userId)
        
        myRecordRef.getDocuments { snapshot, error in
            
            if let error = error {
                
                completion(Result.failure(error))
            }
            
            guard let snapshot = snapshot else { return }
            
            let myRecord = snapshot.documents.compactMap { snapshot in
                
                try? snapshot.data(as: Record.self)
            }
            
            let recordDayy = myRecord.filter { record -> Bool in
                
                let recordDate = Date(timeIntervalSince1970: record.createdTime)
                
                let haseSame = recordDate.hasSame(.year, as: date)
                    && recordDate.hasSame(.month, as: date)
                    && recordDate.hasSame(.day, as: date)
                
                return haseSame
            }
            
//            let recordDay = myRecord.compactMap { (record) -> Record? in
//
//                let recordDate = Date(timeIntervalSince1970: record.createdTime)
//
//                if recordDate.hasSame(.year, as: date)
//                    && recordDate.hasSame(.month, as: date)
//                    && recordDate.hasSame(.day, as: date) {
//
//                    return record
//
//                } else {
//
//                    return nil
//
//                }
//            }
            
            completion(Result.success(recordDayy))
        }
    }
}
