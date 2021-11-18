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
        
//        RecipeManager.shared.recipeIdHandler = { [ weak self ] id in
//
//            guard let strongSelf = self else { return }
//
//            strongSelf.myRecipeId = id
//        }
        
        let recordRef = db.collection(CollectionName.record.rawValue).document()
        
        let record = Record(
            ownerId: userId,
            recordTitle: record.recordTitle,
            recordCategory: record.recordCategory,
            recordNote: record.recordNote,
            focusTime: record.focusTime,
            createdTime: record.createdTime,
            favourite: false,
            recipeId: RecipeManager.shared.myRecipe ?? "default")
        
        do {
            
            try recordRef.setData(from: record)
            
        } catch {
            
            print("Fail to create record.")
        }
    }
}
