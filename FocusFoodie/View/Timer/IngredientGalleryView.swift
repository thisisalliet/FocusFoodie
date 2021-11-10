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
            
            let layer = CAGradientLayer()
            
            layer.frame = contentView.bounds
            
            layer.colors = [UIColor.white.cgColor, UIColor.G1 ?? UIColor.white.cgColor]
            
            layer.startPoint = CGPoint(x: 0, y: 0)
            
            layer.endPoint = CGPoint(x: 0, y: 10)
            
            contentView.layer.insertSublayer(layer, at: 0)
        }
    }
    
    @IBOutlet weak var oilImage: UIImageView!
    
    @IBOutlet weak var knifeImage: UIImageView!
    
    @IBOutlet weak var darkBackground: UIView!
    
    @IBOutlet weak var lightbackground: UIView!
    
    @IBOutlet weak var breadImage: UIImageView!
    
    @IBOutlet weak var vegetableImage: UIImageView!
    
    @IBOutlet weak var meatImage: UIImageView!
    
    @IBOutlet weak var sideImage: UIImageView!
    
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
