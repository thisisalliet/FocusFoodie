//
//  Ingredient.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/27.
//

import Foundation
import UIKit

protocol IngredientItem {

    var image: UIImage? { get }
    
    var name: String? { get }
    
    var minute: Int? { get }
}

enum BreadItem: IngredientItem {
    
    case toast
        
    case baguette
    
    case croissant
    
    var image: UIImage? {
        
        switch self {
            
        case .toast: return UIImage.asset(.icon_baguette)

        case .baguette: return UIImage.asset(.icon_baguette)

        case .croissant: return UIImage.asset(.icon_baguette)
        }
    }
    
    var name: String? {
        
        switch self {
            
        case .toast: return "Toast"

        case .baguette: return "Baguette"

        case .croissant: return "croissant"
        }
    }
    
    var minute: Int? {
        
        switch self {
            
        case .toast: return 1

        case .baguette: return 5

        case .croissant: return 10
        }
    }
}

enum VegetableItem: IngredientItem {
    
    case avocado
    
    case bellPepper
    
    case cucumber
    
    case lettuce
    
    case tomato
    
    case onion
    
    var image: UIImage? {
        
        switch self {
            
        case .avocado: return UIImage.asset(.icon_lettuce)

        case .bellPepper: return UIImage.asset(.icon_lettuce)

        case .cucumber: return UIImage.asset(.icon_lettuce)

        case .lettuce: return UIImage.asset(.icon_lettuce)

        case .tomato: return UIImage.asset(.icon_lettuce)

        case .onion: return UIImage.asset(.icon_lettuce)
        }
    }
    
    var name: String? {
        
        switch self {
            
        case .avocado: return "Advocado"

        case .bellPepper: return "Bell Pepper"

        case .cucumber: return "Cucumer"

        case .lettuce: return "Lettuce"

        case .tomato: return "Tomato"
            
        case .onion: return "Onion"
        }
    }
    
    var minute: Int? {
        
        switch self {
            
        case .avocado: return 5
            
        case .bellPepper: return 10
            
        case .cucumber: return 15
            
        case .lettuce: return 20
            
        case .tomato: return 30
            
        case .onion: return 60
        }
    }
}

enum MeatItem: IngredientItem {
    
    case bacon
    
    case chicken
        
    case falafel
    
    case shrimp
    
    case tuna
    
    case turkey
    
    var image: UIImage? {
        
        switch self {
            
        case .bacon: return UIImage.asset(.icon_baguette)
            
        case .chicken: return UIImage.asset(.icon_baguette)
            
        case .falafel: return UIImage.asset(.icon_baguette)
            
        case .shrimp: return UIImage.asset(.icon_baguette)
            
        case .tuna: return UIImage.asset(.icon_baguette)
            
        case .turkey: return UIImage.asset(.icon_baguette)
        }
    }
    
    var name: String? {
        
        switch self {
            
        case .bacon: return "Bacon"
            
        case .chicken: return "Chicken"

        case .falafel: return "Falafel"

        case .shrimp: return "Shrimp"

        case .tuna: return "Tuna"

        case .turkey: return "Turkey"
        }
    }
    
    var minute: Int? {
        
        switch self {
            
        case .bacon: return 5

        case .chicken: return 10

        case .falafel: return 15

        case .shrimp: return 20

        case .tuna: return 30

        case .turkey: return 60
        }
    }
}

enum SideItem: IngredientItem {
    
    case egg
    
    case peanutButter
    
    case honey
    
    case mayonnaise
    
    case mustard
    
    case cheese
    
    var image: UIImage? {
        
        switch self {
            
        case .egg: return UIImage.asset(.icon_cheese)
            
        case .peanutButter: return UIImage.asset(.icon_cheese)
            
        case .honey: return UIImage.asset(.icon_cheese)
            
        case .mayonnaise: return UIImage.asset(.icon_cheese)
            
        case .mustard: return UIImage.asset(.icon_cheese)
            
        case .cheese: return UIImage.asset(.icon_cheese)
        }
    }
    
    var name: String? {
        
        switch self {
            
        case .egg: return "Egg"
            
        case .peanutButter: return "Peanut Butter"
            
        case .honey: return "Honey"
            
        case .mayonnaise: return "Mayonnaise"
            
        case .mustard: return "Mustard"
            
        case .cheese: return "Cheese"
        }
    }
    
    var minute: Int? {
        
        switch self {
            
        case .egg: return 10
            
        case .peanutButter: return 20
            
        case .honey: return 30
            
        case .mayonnaise: return 40
            
        case .mustard: return 50
            
        case .cheese: return 60
        }
    }
}

