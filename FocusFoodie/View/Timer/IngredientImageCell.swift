//
//  IngredientImageCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

class IngredientImageCell: UITableViewCell {

    @IBOutlet weak var oilImage: UIImageView! {
        
        didSet {
            
            oilImage.image = .asset(.icon_oil)
        }
    }
    
    @IBOutlet weak var knifeImage: UIImageView! {
        
        didSet {
            
            knifeImage.image = .asset(.icon_knife)
        }
    }
    
    @IBOutlet weak var tableViewOne: UIView! {
        
        didSet {
            
            tableViewOne.backgroundColor = .T1
        }
    }
    
    @IBOutlet weak var tableViewTwo: UIView! {
        
        didSet {
            
            tableViewTwo.backgroundColor = .T2
        }
    }
    
    @IBOutlet weak var firstIngredientImage: UIImageView! {
        
        didSet {
            
            firstIngredientImage.contentMode = .scaleAspectFit

            firstIngredientImage.image = .asset(.icon_bread)
        }
    }
    
    @IBOutlet weak var secondIngredientImage: UIImageView! {
        
        didSet {
            
            secondIngredientImage.contentMode = .scaleAspectFit
            
            secondIngredientImage.image = .asset(.icon_bread)
        }
    }
    
    @IBOutlet weak var thirdIngredientImage: UIImageView! {
        
        didSet {
            
            thirdIngredientImage.contentMode = .scaleAspectFit
            
            thirdIngredientImage.image = .asset(.icon_bread)
        }
    }
    
    @IBOutlet weak var fourthIngredientImage: UIImageView! {
        
        didSet {
            
            fourthIngredientImage.contentMode = .scaleAspectFit
            
            fourthIngredientImage.image = .asset(.icon_bread)
        }
    }
}
