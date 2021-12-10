//
//  ToastView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/12/10.
//

import UIKit

class ToastView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var toastImage: UIImageView!
    
    @IBOutlet weak var vegetableImage: UIImageView!
    
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
            String(describing: ToastView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
    
    func layoutView(recipe: Recipe) {
        
        let vegetableIcon = VegetableItem(rawValue: recipe.vegetable?.lowercased() ?? "")?.image

        vegetableImage.image = vegetableIcon
    }
}
