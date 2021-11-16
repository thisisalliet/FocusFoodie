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
    
    weak var delegate: TimerEditControllerDelegate?

    static let shared = RecipeManager()
    
    let userId: String = {
        
        if let user = Auth.auth().currentUser {
            
            return user.uid
            
        } else {
            
            return "0"
        }
    }()
    
    func createRecipe(recipe: Recipe) {
        
        let recipeRef = db.collection(CollectionName.recipe.rawValue)
        
        let recipeId  = recipeRef.document().documentID
        
        let recipe = Recipe(bread: recipe.bread,
                            vegetable: recipe.vegetable,
                            meat: recipe.meat,
                            side: recipe.side,
                            focusTime: recipe.focusTime,
                            recipeId: recipeId)
        do {
            
            try recipeRef.document().setData(from: recipe)
            
        } catch {
            
            print("Fail to create recipe.")
        }
    }
}
