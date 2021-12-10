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
        
    static let shared = RecordManager()
    
    func createRecord(record: Record) {
        
        let recordRef = db.collection(CollectionName.record.rawValue).document()
        
        do {
            
            try recordRef.setData(from: record)
            
        } catch {
            
            print("Fail to create record.")
        }
    }
    
    func fetchRecord(date: Date, completion: @escaping (Result<[Record], Error>) -> Void) {
        
        let myRecordRef = db.collection(CollectionName.record.rawValue)
            .whereField("owner_id", isEqualTo: UserManager.shared.currentUserId)
        // 排
        
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
            
            completion(Result.success(recordDay))
        }
    }
}
