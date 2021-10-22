//
//  ProfileView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var profileImage: UIImageView! {
        
        didSet {

            profileImage.cornerRadius = 15
            
            profileImage.image = UIImage.asset(.Icons_36px_Profile_Normal)
        }
    }
}
