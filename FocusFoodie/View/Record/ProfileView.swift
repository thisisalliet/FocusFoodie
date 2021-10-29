//
//  ProfileView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView! {
        
        didSet {
            
            profileImage.image = UIImage.asset(.icon_loading)
        }
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        initContentView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        initContentView()
//    }
//
//    private func initContentView() {
//
//        backgroundColor = UIColor.white

//        Bundle.main.loadNibNamed(
//            String(describing: ProfileView.self),
//            owner: self,
//            options: nil
//        )

//        stickSubView(contentView)
//    }
}
