//
//  Ingredient.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/27.
//

import UIKit
import Foundation

protocol IngredientObject {

    var type: IngredientCategory { get }
    
    var image: UIImage? { get }
    
    var colorfulImage: UIImage? { get }

    var title: String { get }

    var minute: Int { get }
}

enum IngredientCategory: Int {
    
    case bread
    
    case vegetable
    
    case meat
    
    case side
}

enum BreadItem: IngredientObject, CaseIterable {
    
    case toast
    
    case burgerBun
        
    case baguette
    
    case croissant
    
    case flatBread
        
    var type: IngredientCategory {
        
        .bread
    }
    
    var image: UIImage? {
        
        switch self {
            
        case .toast: return UIImage.asset(.icon_toast)
            
        case .burgerBun: return UIImage.asset(.icon_burger_bun)

        case .baguette: return UIImage.asset(.icon_baguette)

        case .croissant: return UIImage.asset(.icon_croissant)
            
        case .flatBread: return UIImage.asset(.icon_flatbread)
        }
    }
    
    var colorfulImage: UIImage? {
        
        switch self {
            
        case .toast: return UIImage.asset(.icon_toast_color)
            
        case .burgerBun: return UIImage.asset(.icon_toast_color)
            
        case .baguette: return UIImage.asset(.icon_toast_color)
            
        case .croissant: return UIImage.asset(.icon_toast_color)
            
        case .flatBread: return UIImage.asset(.icon_toast_color)
            
        }
    }
    
    
    var title: String {
        
        switch self {
            
        case .toast: return "Toast"
            
        case .burgerBun: return "Bun"
            
        case .baguette: return "Baguette"

        case .croissant: return "Croissant"
            
        case .flatBread: return "Flatbread"
        }
    }
    
    var minute: Int {
        
        switch self {
            
        case .toast: return 1
            
        case .burgerBun: return 3

        case .baguette: return 5

        case .croissant: return 10
            
        case .flatBread: return 15
        }
    }
}

enum VegetableItem: String, IngredientObject, CaseIterable {
    
    case avocado
    
    case bellPepper
    
    case cucumber
    
    case lettuce
    
    case tomato
    
    case onion
    
    var type: IngredientCategory {
        
        .vegetable
    }
    
    var image: UIImage? {
        
        switch self {
            
        case .avocado: return UIImage.asset(.icon_avocado)

        case .bellPepper: return UIImage.asset(.icon_bell_pepper)

        case .cucumber: return UIImage.asset(.icon_cucumber)

        case .lettuce: return UIImage.asset(.icon_lettuce)

        case .tomato: return UIImage.asset(.icon_tomato)

        case .onion: return UIImage.asset(.icon_onion)
        }
    }
    
    var colorfulImage: UIImage? {
        
        switch self {
            
        case .avocado: return UIImage.asset(.icon_onion_color)
            
        case .bellPepper: return UIImage.asset(.icon_onion_color)
            
        case .cucumber: return UIImage.asset(.icon_cucumber_color)
            
        case .lettuce: return UIImage.asset(.icon_lettuce_color)
            
        case .tomato: return UIImage.asset(.icon_tomato_color)
            
        case .onion: return UIImage.asset(.icon_onion_color)
        }
    }
    
    var title: String {
        
        switch self {
            
        case .avocado: return "Avocado"

        case .bellPepper: return "Pepper"

        case .cucumber: return "Cucumber"

        case .lettuce: return "Lettuce"

        case .tomato: return "Tomato"
            
        case .onion: return "Onion"
        }
    }
    
    var minute: Int {
        
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

enum MeatItem: String, IngredientObject, CaseIterable {
    
    case bacon
    
    case tuna
        
    case falafel
    
    case shrimp
    
    case beef
    
    case turkey
    
    var type: IngredientCategory {
        
        .meat
    }
    
    var image: UIImage? {
        
        switch self {
            
        case .bacon: return UIImage.asset(.icon_bacon)
            
        case .tuna: return UIImage.asset(.icon_tuna)
            
        case .falafel: return UIImage.asset(.icon_falafel)
            
        case .shrimp: return UIImage.asset(.icon_shrimp)
            
        case .beef: return UIImage.asset(.icon_beef)
            
        case .turkey: return UIImage.asset(.icon_turkey)
        }
    }
    
    var colorfulImage: UIImage? {
        
        switch self {
            
        case .bacon: return UIImage.asset(.icon_bacon_color)
            
        case .tuna: return UIImage.asset(.icon_bacon_color)
            
        case .falafel: return UIImage.asset(.icon_bacon_color)
            
        case .shrimp: return UIImage.asset(.icon_shrimp_color)
            
        case .beef: return UIImage.asset(.icon_bacon_color)
            
        case .turkey: return UIImage.asset(.icon_bacon_color)
        }
    }
    
    
    var title: String {
        
        switch self {
            
        case .bacon: return "Bacon"
            
        case .tuna: return "Tuna"

        case .falafel: return "Falafel"

        case .shrimp: return "Shrimp"

        case .beef: return "Beef"

        case .turkey: return "Turkey"
        }
    }
    
    var minute: Int {
        
        switch self {
            
        case .bacon: return 5

        case .tuna: return 10

        case .falafel: return 15

        case .shrimp: return 20

        case .beef: return 30

        case .turkey: return 60
        }
    }
}

enum SideItem: String, IngredientObject, CaseIterable {
    
    case egg
    
    case honey
    
    case mayonnaise
    
    case ketchup
    
    case mustard
    
    case cheese
    
    var type: IngredientCategory {
     
        .side
    }
    
    var image: UIImage? {
        
        switch self {
            
        case .egg: return UIImage.asset(.icon_egg)
            
        case .honey: return UIImage.asset(.icon_honey)
            
        case .mayonnaise: return UIImage.asset(.icon_mayonnaise)
            
        case .ketchup: return UIImage.asset(.icon_ketchup)
            
        case .mustard: return UIImage.asset(.icon_mustard)
            
        case .cheese: return UIImage.asset(.icon_cheese)
        }
    }
    
    var colorfulImage: UIImage? {
        
        switch self {
            
        case .egg: return UIImage.asset(.icon_egg_color)
            
        case .honey: return UIImage.asset(.icon_honey)
            
        case .mayonnaise: return UIImage.asset(.icon_mayonnaise)
            
        case .ketchup: return UIImage.asset(.icon_ketchup)
            
        case .mustard: return UIImage.asset(.icon_mustard)
            
        case .cheese: return UIImage.asset(.icon_cheese_color)
        }
    }
    
    var title: String {
        
        switch self {
            
        case .egg: return "Egg"
            
        case .honey: return "Honey"
            
        case .mayonnaise: return "Mayonnaise"
            
        case .ketchup: return "Ketchup"
            
        case .mustard: return "Mustard"
            
        case .cheese: return "Cheese"
        }
    }
    
    var minute: Int {
        
        switch self {
            
        case .egg: return 10
            
        case .honey: return 20
            
        case .mayonnaise: return 30
            
        case .ketchup: return 40
            
        case .mustard: return 50
            
        case .cheese: return 60
        }
    }
}
