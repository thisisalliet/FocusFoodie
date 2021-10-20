//
//  ProfileView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

@IBDesignable class ProfileView: UIView {

    @IBOutlet weak var profileImage: UIImageView! {
        
        didSet {
            
            profileImage.image = UIImage.asset(.Icons_36px_Profile_Normal)
        }
    }
}
