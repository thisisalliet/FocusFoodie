//
//  IngredientCollectionViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    var bread = ["Baguette", "Burger Buns", "Croissant", "Toast"]
    
    var veggies = ["Avocado", "Bell Pepper", "Cucumber", "Lettuce", "Tomato"]
    
    var sides = ["Boiled Egg", "Cheese", "Jalapeño", "Onion", "Pickel", "Scrambled Egg"]
    
    var meats = ["Bacon", "Chicken", "Falafel", "Meatball", "Shrimp", "Tuna", "Turkey"]
    
    @IBOutlet weak var ingredientImage: UIImageView! {
        
        didSet {
            
            ingredientImage.contentMode = .scaleAspectFit
            
            ingredientImage.image = .asset(.icon_loading)
        }
    }
    
    @IBOutlet weak var ingredientLabel: UILabel! {
        
        didSet {
            
            ingredientLabel.text = "ingredient"
            
            ingredientLabel.textColor = .B5
            
            ingredientLabel.font = UIFont.regular(size: 16.0)
        }
    }
    
    @IBOutlet weak var minLabel: UILabel! {
        
        didSet {
            
            minLabel.text = "5 min"
            
            minLabel.textColor = .B5
            
            minLabel.font = UIFont.light(size: 14.0)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
