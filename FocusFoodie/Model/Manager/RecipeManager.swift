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
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    var myRecipeId: String?
    
    func createRecipe(recipe: Recipe, completion: @escaping (Result<String, Error>) -> Void) {
        
        let recipeRef = recipes.document()
        
        //        let userRef = recipes.document(userId)
        
        let recipeId = recipeRef.documentID
        
        let recipeWithId = Recipe(
            bread: recipe.bread,
            vegetable: recipe.vegetable,
            meat: recipe.meat,
            side: recipe.side,
            focusTime: recipe.focusTime,
            recipeId: recipeId)
                
        do {
            
            try recipeRef.setData(from: recipeWithId)
            
            completion(Result.success(recipeId))
                        
        } catch {
            
            print("Fail to create recipe.")
            
            completion(Result.failure(error))
        }
        
        //        userRef.getDocument { document, error in
        //
        //            if let document = document, document.exists {
        //
        //                document.reference.updateData([
        //                    "recipe_list" : FieldValue.arrayUnion([self.myRecipeId as Any])
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
    
    func fetchRecipeInfo(recipeId: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        
        recipes.document(recipeId).getDocument { document, error in
            
            if let error = error {
                
                completion(Result.failure(error))
            }
            
            guard let document = document,
                  document.exists
                    
            else {
                
                print("Couldn't find recipe.")
                
                return
            }
            
            do {
                
                let recipe = try? document.data(as: Recipe.self)
                
                if let recipe = recipe {
                    
                    completion(Result.success(recipe))
                }
                
            } catch {
                
                print(error)
            }
        }
    }
}
