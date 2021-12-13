//
//  CommunityTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
        
    @IBOutlet weak var multiButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
        
    @IBOutlet weak var inviteBackground: UIImageView!
    
    var touchHandler: (() -> Void)? {
        
        didSet {
            
            if touchHandler == nil {
                
                multiButton.isHidden = true
                
            } else {
                
                multiButton.isHidden = false
            }
        }
    }
    
    @IBAction func didTappedMultiButton(_ sender: UIButton) {
        
        touchHandler?()
    }
    
    func layoutCell(name: String, email: String) {
        
        multiButton.setBackgroundImage(UIImage.asset(.icon_cross_green), for: .normal)

        nameLabel.text = name

        emailLabel.text = email
    }
    
    func layoutCellWithInvitation(name: String, email: String) {

        nameLabel.text = name

        emailLabel.text = email
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        touchHandler = nil
    }
}
