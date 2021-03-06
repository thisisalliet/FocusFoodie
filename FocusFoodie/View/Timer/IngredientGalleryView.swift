//
//  IngredientView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/2.
//

import UIKit

class IngredientGalleryView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var plusImage: UIImageView!
    
    @IBOutlet weak var minusImage: UIImageView!
    
    @IBOutlet weak var breadImage: UIImageView! {
        
        didSet {
            
            breadImage.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var vegetableImage: UIImageView! {
        
        didSet {
            
            vegetableImage.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var meatImage: UIImageView! {
        
        didSet {
            
            meatImage.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var sideImage: UIImageView! {
        
        didSet {
            
            sideImage.cornerRadius = 25
        }
    }
        
    @IBOutlet weak var totalMinuteLabel: UILabel! {
        
        didSet {
            
            totalMinuteLabel.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var minuteLabel: UILabel!
    
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
