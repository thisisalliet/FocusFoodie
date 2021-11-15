//
//  IngredientView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/2.
//

import UIKit

class IngredientItemView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var ingredientImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var minLabel: UILabel!
    
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
            String(describing: IngredientItemView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
    
    func layoutCell(image: UIImage, title: String, minute: Int, isSelected: Bool) {
        
        ingredientImage.image = image
        
        titleLabel.text = title
        
        minLabel.text = "\(minute) min"
        
        if isSelected {
            
            contentView.backgroundColor = .Y1
            
        } else {
            
            contentView.backgroundColor = .white
        }
    }
}
