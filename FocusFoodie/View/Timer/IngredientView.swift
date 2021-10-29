//
//  IngredientImageCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

class IngredientView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var oilImage: UIImageView! {
        
        didSet {
            
            oilImage.contentMode = .scaleAspectFit
            
            oilImage.image = .asset(.icon_oil)
        }
    }
    
    @IBOutlet weak var knifeImage: UIImageView! {
        
        didSet {
            
            knifeImage.contentMode = .scaleAspectFit
            
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
        }
    }
    
    @IBOutlet weak var secondIngredientImage: UIImageView! {
        
        didSet {
            
            secondIngredientImage.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var thirdIngredientImage: UIImageView! {
        
        didSet {
            
            thirdIngredientImage.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var fourthIngredientImage: UIImageView! {
        
        didSet {
            
            fourthIngredientImage.contentMode = .scaleAspectFit
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initView()
    }
    
    private func initView() {
        
        backgroundColor = .B1
        
        Bundle.main.loadNibNamed(
            String(describing: IngredientView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
}
