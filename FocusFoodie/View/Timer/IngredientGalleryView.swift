//
//  IngredientView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/2.
//

import UIKit

class IngredientGalleryView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var oilImage: UIImageView!
    
    @IBOutlet weak var knifeImage: UIImageView!
    
    @IBOutlet weak var darkBackground: UIView!
    
    @IBOutlet weak var lightbackground: UIView!
    
    @IBOutlet weak var firstIngredientImage: UIImageView!
    
    @IBOutlet weak var secondIngredientImage: UIImageView!
    
    @IBOutlet weak var thirdIngredientImage: UIImageView!
    
    @IBOutlet weak var fourthIngredientImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    private func initView() {
        
        Bundle.main.loadNibNamed(
            String(describing: IngredientGalleryView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
}
