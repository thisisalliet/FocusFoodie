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
    
    var recipeIdHandler: ((_ id: String) -> Void)?
    
    static let shared = RecipeManager()
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    var myRecipe: String?
    
    func createRecipe(recipe: Recipe) {
        
        let recipeRef = db.collection(CollectionName.recipe.rawValue).document()
        
        let userRef = db.collection(CollectionName.user.rawValue).document(userId)
        
        let recipeId = recipeRef.documentID
        let recipeWithId = Recipe(bread: recipe.bread,
                            vegetable: recipe.vegetable,
                            meat: recipe.meat,
                            side: recipe.side,
                            focusTime: recipe.focusTime,
                            recipeId: recipeId)
        
        myRecipe = recipeId
        
//        recipeIdHandler?(myRecipe)
        
        do {
            
            try recipeRef.setData(from: recipeWithId)
            
        } catch {
            
            print("Fail to create recipe.")
        }
        
        userRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                document.reference.updateData([
                    "recipe_list" : FieldValue.arrayUnion([self.myRecipe as Any])
                ])
                
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
