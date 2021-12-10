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
    
    let recipes = Firestore.firestore().collection(CollectionName.recipe.rawValue)

    let users = Firestore.firestore().collection(CollectionName.user.rawValue)

    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
//    var myRecipe: String?
    
    func createRecipe(recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        
        let recipeRef = recipes.document()
        
        let userRef = users.document(userId)
        
        let recipeId = recipeRef.documentID
        let recipeWithId = Recipe(bread: recipe.bread,
                            vegetable: recipe.vegetable,
                            meat: recipe.meat,
                            side: recipe.side,
                            focusTime: recipe.focusTime,
                            recipeId: recipeId)
        
//        myRecipe = recipeId
        
//        recipeIdHandler?(myRecipe)
        
        do {
            
            try recipeRef.setData(from: recipeWithId, completion: { error in
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(recipeWithId))
                }
            })
            
        } catch {
            completion(.failure(error))
            print("Fail to create recipe.")
        }
        
//        userRef.getDocument { document, error in
//
//            if let document = document, document.exists {
//
//                document.reference.updateData([
//                    "recipe_list" : FieldValue.arrayUnion([self.myRecipe as Any])
//                ])
//
//            } else {
//
//                if let error = error {
//                    print(error)
//                }
//            }
//        }
    }
    
    func fetchRecipe(recipeId: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        
//        let recipeRef = recipes.document()
//
//        let userRef = users.document(userId)
//
//        let recipeId = recipeRef.documentID
//
//
        recipes.document(recipeId).getDocument{ document, error in
            
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
                
                let recipe = try document.data(as: Recipe.self)
                guard let recipe = recipe else { return }
                completion(Result.success(recipe))

                
            } catch {
                completion(Result.failure(error))
                print(error)
            }
            
        }
    }
}
