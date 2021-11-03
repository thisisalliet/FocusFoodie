//
//  IngredientView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/2.
//

import UIKit

class IngredientItemView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var ingredientImage: UIImageView! {
        
        didSet {
            
            ingredientImage.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        
        didSet {
            
            titleLabel.textColor = .B5
            
            titleLabel.font = UIFont.regular(size: 14.0)
        }
    }
    
    @IBOutlet weak var minLabel: UILabel! {
        
        didSet {
            
            minLabel.textColor = .B5
            
            minLabel.font = UIFont.light(size: 14.0)
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

            contentView.backgroundColor = .B1
            
        } else {

            contentView.backgroundColor = .B2
        }
    }
}

