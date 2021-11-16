//
//  IngredientView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/2.
//

import UIKit

class IngredientGalleryView: UIView {

    @IBOutlet weak var contentView: UIView! {
        
        didSet {
            
            contentView.cornerRadius = 10
            
            contentView.borderWidth = 5
            
            contentView.borderColor = .Y2
        }
    }
    
    @IBOutlet weak var breadImage: UIImageView!
    
    @IBOutlet weak var vegetableImage: UIImageView!
    
    @IBOutlet weak var meatImage: UIImageView!
    
    @IBOutlet weak var sideImage: UIImageView!
    
    @IBOutlet weak var timerImage: UIImageView! {
        
        didSet {
            
            timerImage.transform.rotated(by: 10.0)
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
