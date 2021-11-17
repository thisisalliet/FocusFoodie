//
//  RecipeManager.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/15.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecipeManager {
    
    lazy var db = Firestore.firestore()
    
    static let shared = RecipeManager()
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    func createRecipe(recipe: Recipe) {
        
        let recipeRef = db.collection(CollectionName.recipe.rawValue).document()
        
        let userRef = db.collection(CollectionName.user.rawValue).document(userId)
                
        let recipe = Recipe(bread: recipe.bread,
                            vegetable: recipe.vegetable,
                            meat: recipe.meat,
                            side: recipe.side,
                            focusTime: recipe.focusTime,
                            recipeId: recipeRef.documentID)
        
        let myRecipe = recipe.recipeId
        
        do {
            
            try recipeRef.setData(from: recipe)
            
        } catch {
            
            print("Fail to create recipe.")
        }
        
        userRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData([
                    "recipe_list" : FieldValue.arrayUnion([myRecipe])
                ])
                
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func fetchTime(completion: @escaping (Result<[User], Error>) -> Void) {
        
//        let timerRef = db.collection(CollectionName.recipe.rawValue)
//            .whereField("bread", isEqualTo: recipe.bread as Any)
//            .whereField("vegetable", isEqualTo: recipe.vegetable as Any)
//            .whereField("meat", isEqualTo: recipe.meat as Any)
//            .whereField("side", isEqualTo: recipe.side as Any)
//
//        timerRef.getDocuments { snapshot, error in
//
//            if let error = error {
//
//                completion(Result.failure(error))
//            }
//
//            guard let snapshot = snapshot else { return }
//
//            let currentRecipe = snapshot.documents.compactMap { snapshot in
//
//                try? snapshot.data(as: Recipe.self)
//            }
//
//            completion(Result.success(currentRecipe))
//        }
    }
}
