//
//  Ingredient.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/27.
//

import Foundation
import UIKit

let breads = [
    
    Bread(image: (.asset(.icon_baguette))!, name: "Toast", minute: 1),

    Bread(image: (.asset(.icon_baguette))!, name: "Burger Buns", minute: 3),
    
    Bread(image: (.asset(.icon_baguette))!, name: "Baguette", minute: 5),
    
    Bread(image: (.asset(.icon_baguette))!, name: "Croissant", minute: 10)
]

let veggies = [
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Avocado", minute: 5),
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Bell Pepper", minute: 10),
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Cucumber", minute: 15),
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Lettuce", minute: 20),
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Onion", minute: 30),
    
    Veggie(image: (.asset(.icon_lettuce))!, name: "Tomato", minute: 60)
]

let meats = [

    Meat(image: (.asset(.icon_bacon))!, name: "Bacon", minute: 5),
    
    Meat(image: (.asset(.icon_bacon))!, name: "Chicken", minute: 10),
    
    Meat(image: (.asset(.icon_bacon))!, name: "Falafel", minute: 15),
    
    Meat(image: (.asset(.icon_bacon))!, name: "Shrimp", minute: 20),
    
    Meat(image: (.asset(.icon_bacon))!, name: "Tuna", minute: 30),
    
    Meat(image: (.asset(.icon_bacon))!, name: "Turkey", minute: 60)
]

let sides = [

    Side(image: (.asset(.icon_cheese))!, name: "Egg", minute: 10),
    
    Side(image: (.asset(.icon_cheese))!, name: "Peanut Butter", minute: 20),
    
    Side(image: (.asset(.icon_cheese))!, name: "Honey", minute: 30),
    
    Side(image: (.asset(.icon_cheese))!, name: "Mayonnaise", minute: 40),
    
    Side(image: (.asset(.icon_cheese))!, name: "Mustard", minute: 50),
    
    Side(image: (.asset(.icon_cheese))!, name: "Cheese", minute: 60)
]

struct Bread {
    
    let image: UIImage
    
    let name: String
    
    let minute: Int
}

struct Veggie {
    
    let image: UIImage
    
    let name: String
    
    let minute: Int
}

struct Meat {
    
    let image: UIImage
    
    let name: String
    
    let minute: Int
}

struct Side {
    
    let image: UIImage
    
    let name: String
    
    let minute: Int
}
