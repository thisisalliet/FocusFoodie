//
//  ComingSoonView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/30.
//

import UIKit
import Lottie

class ComingSoonView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var animationView: AnimationView! {
        
        didSet {
            
            animationView.contentMode = .scaleAspectFit
            
            animationView.loopMode = .loop
            
            animationView.animationSpeed = 0.5
            
            animationView.play()
        }
    }
    
    @IBOutlet weak var comingSoonLabel: UILabel! {
        
        didSet {
            
            comingSoonLabel.text = "Coming Soon..."
            
            comingSoonLabel.textColor = .G3
                        
            comingSoonLabel.font = .regular(size: 20)
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
            String(describing: ComingSoonView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
}
